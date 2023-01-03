const express = require('express')
const { randomBytes } = require('crypto')
const axios = require('axios')
const app = express()
const cors = require('cors') 

const PORT = process.env.PORT || 4001
const commentsByPostId = []

app.use(express.json());
app.use(cors())

app.get('/posts/:id/comments', (req, res)=> {
    res.status(200).send(commentsByPostId[req.params.id] || [])
})

app.post('/posts/:id/comment', async (req, res) => {
    const id = randomBytes(4).toString('hex')
    const { content } = req.body

    const comments = commentsByPostId[req.params.id] || []

    comments.push({ commentId: id, content })

    commentsByPostId[req.params.id] = comments

    await axios.post(`http://localhost:4005/events`, {
        type: "CommentCreated",
        data: { id, content, postId: req.params.id }
    }).catch((error)=>{console.log(error.message)})

    res.status(201).send(comments)
} )

app.post('/events', (req, res) => {
    console.log(`Comments Service received an event. `, req.body.type)

    res.send({})
})

app.listen(PORT, () => console.log(`Comments Service is up and running on port ${PORT}`))