# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
default_images = [
  { title: '1', link: 'https://images.unsplash.com/photo-1509782642997-4befdc4b21c9?ixlib' \
  '=rb-1.2.1&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '2', link: 'https://images.unsplash.com/photo-1509207340194-6128754fe04f?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '3', link: 'https://images.unsplash.com/photo-1506655624258-6e7d8102f90f?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2605&q=80', tag_list: '' },
  { title: '4', link: 'https://images.unsplash.com/photo-1482017276394-d2ddc6d4c978?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '5', link: 'https://images.unsplash.com/photo-1493849749377-e4f82d0a8319?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2248&q=80', tag_list: '' },
  { title: '6', link: 'https://images.unsplash.com/photo-1506437234914-6875b54598bd?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '7', link: 'https://images.unsplash.com/photo-1496843916299-590492c751f4?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2251&q=80', tag_list: '' },
  { title: '8', link: 'https://images.unsplash.com/photo-1505242892805-4fc26a28e478?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '9', link: 'https://images.unsplash.com/photo-1497050284693-c7c48a96240a?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80', tag_list: '' },
  { title: '10', link: 'https://images.unsplash.com/photo-1496637721836-f46d116e6d34?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80', tag_list: '' },
  { title: '11', link: 'https://images.unsplash.com/photo-1495652286171-4bba4cd113c5?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=80', tag_list: '' },
  { title: '12', link: 'https://images.unsplash.com/photo-1485242707039-8243733a892e?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1275&q=80', tag_list: '' },
  { title: '13', link: 'https://images.unsplash.com/photo-1502035618526-6b2f1f5bca1b?ixlib' \
  '=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2304&q=80', tag_list: '' },
  { title: '14', link: 'https://images.unsplash.com/photo-1464692805480-a69dfaafdb0d?ixlib' \
  '=rb-1.2.1&auto=format&fit=crop&w=2250&q=80', tag_list: '' },
  { title: '15', link: 'https://media.gettyimages.com/photos/abstract-glass-architecture' \
  '-picture-id164191362?s=2048x2048', tag_list: '' },
  { title: '16', link: 'https://media.gettyimages.com/photos/plastic-bottle-pollution-that' \
  '-floats-in-the-ocean-picture-id1181430920?s=2048x2048', tag_list: '' },
  { title: '17', link: 'https://media.gettyimages.com/photos/christmas-tree-picture-id1172396140?s=2048x2048' },
  { title: '18', link: 'https://media.gettyimages.com/photos/one-male-tourist-visiting-the' \
  '-yuanyang-rice-terraceyuannanchina-picture-id1135346294?s=2048x2048', tag_list: '' },
  { title: '19', link: 'https://media.gettyimages.com/photos/portrait-of-customer-relaxing' \
  '-in-menswear-store-picture-id1133789958?s=2048x2048', tag_list: '' },
  { title: '20', link: 'https://media.gettyimages.com/photos/mountaineer-jumps-over-large' \
  '-crevasse-picture-id1184545436?s=2048x2048', tag_list: '' }
]

Image.create(default_images)
