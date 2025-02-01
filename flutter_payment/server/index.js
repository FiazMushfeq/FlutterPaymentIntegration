require('dotenv').config()
const express = require('express')
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY)
const app = express()

app.set('view engine', 'ejs')

app.get('/', (req, res) => {
    res.render('index.ejs')
})

app.post('/checkout', async (req, res) => {
    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: [
            {
                price_data: {
                    currency: 'usd',
                    product_data: {
                        name: 'Node.js and Exp Book',
                    },
                    unit_amount: 50 * 100,
                },
                quantity: 1,
            },
            {
                price_data: {
                    currency: 'usd',
                    product_data: {
                        name: 'JS Shirt',
                    },
                    unit_amount: 20 * 100,
                },
                quantity: 2,
            }
        ],
        mode: 'payment',
        shipping_address_collection: {
            allowed_countries: ['US', 'CA'],
        },
        success_url: `${process.env.BASE_URL}/complete?session_id={CHECKOUT_SESSION_ID}`,
        cancel_url: `${process.env.BASE_URL}/cancel`,
    })
    res.redirect(session.url)
})

app.get('/cancel', (req, res) => {
    res.redirect('/')
})

app.listen(3000, () => console.log('Server is running on port 3000'))