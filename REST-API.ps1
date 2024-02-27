# Chuck Norris API

$randomJoke = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random"
$randomJoke

# Selve joken
$randomJoke.value

# Kategorier
$categories = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/categories"

# List kategoier
$categories

$categories | Out-GridView -PassThru | ForEach-Object {
    $joke = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random?category=$_"
    $joke.value
}