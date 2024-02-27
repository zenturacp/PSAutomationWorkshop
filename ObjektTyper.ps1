# Custom Object
$CustomObject = [PSCustomObject]@{
    Name = "John Doe"
    Age = 25
    City = "New York"
}
$CustomObject

# Class
class Person{
    [string]$Name
    [int]$Age
    [string]$City
}
$ClassObject = [Person]::new()
$ClassObject.Name = "John Doe"
$ClassObject.Age = 25
$ClassObject.City = "New York"
$ClassObject

# Class med metoder
class PersonExtended{
    [string]$Name
    [int]$Age
    [string]$City

    [string] GetInfo(){
        return "Name: $($this.Name), Age: $($this.Age), City: $($this.City)"
    }
}
$ClassObject = [PersonExtended]::new()
$ClassObject.Name = "John Doe"
$ClassObject.Age = 25
$ClassObject.City = "New York"
$ClassObject.GetInfo()
