--Check for collision between two objects
function CheckCollision(object1, object2)
  return object1.x < object2.x+object2.width and
         object2.x < object1.x+object1.width and
         object1.y < object2.y+object2.height and
         object2.y < object1.y+object1.height
end
