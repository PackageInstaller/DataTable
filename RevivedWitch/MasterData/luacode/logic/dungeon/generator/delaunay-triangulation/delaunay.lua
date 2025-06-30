-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/delaunay-triangulation/delaunay.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local setmetatable = setmetatable
local tostring = tostring
local assert = assert
local unpack = unpack
local remove = table.remove
local sqrt = math.sqrt
local max = math.max
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local Edge = require("logic.dungeon.generator.delaunay-triangulation.edge")
local Triangle = require("logic.dungeon.generator.delaunay-triangulation.triangle")
local Delaunay = {Point = Point, Edge = Edge, Triangle = Triangle, _VERSION = "0.1"}
Delaunay.triangulate = function(...)
  -- function num : 0_0 , upvalues : assert, Triangle, unpack, max, _ENV, Point, remove
  local vertices = {...}
  local nvertices = #vertices
  assert(nvertices > 2, "Cannot triangulate, needs more than 3 vertices")
  if nvertices == 3 then
    return {Triangle(unpack(vertices))}
  end
  local trmax = nvertices * 4
  local minX, minY = (vertices[1]).x, (vertices[1]).y
  local maxX, maxY = minX, minY
  for i = 1, #vertices do
    local vertex = vertices[i]
    vertex.id = i
    if vertex.x < minX then
      minX = vertex.x
    end
    if vertex.y < minY then
      minY = vertex.y
    end
    if maxX < vertex.x then
      maxX = vertex.x
    end
    if maxY < vertex.y then
      maxY = vertex.y
    end
  end
  local dx, dy = maxX - minX, maxY - minY
  local deltaMax = max(dx, dy)
  local midx, midy = (math.floor)((minX + maxX) * 0.5), (math.floor)((minY + maxY) * 0.5)
  local p1 = (Point.Create)(midx - 2 * deltaMax, midy - deltaMax)
  local p2 = (Point.Create)(midx, midy + 2 * deltaMax)
  local p3 = (Point.Create)(midx + 2 * deltaMax, midy - deltaMax)
  p1.id = nvertices + 1
  vertices[p1.id] = p1
  vertices[p2.id] = p2
  vertices[p3.id] = p3
  local triangles = {}
  triangles[#triangles + 1] = (Triangle.Create)(vertices[nvertices + 1], vertices[nvertices + 2], vertices[nvertices + 3])
  for i = 1, nvertices do
    local edges = {}
    local ntriangles = #triangles
    for j = #triangles, 1, -1 do
      local curTriangle = triangles[j]
      if curTriangle:inCircumCircle(vertices[i]) then
        edges[#edges + 1] = curTriangle.e1
        edges[#edges + 1] = curTriangle.e2
        edges[#edges + 1] = curTriangle.e3
        remove(triangles, j)
      end
    end
    for j = #edges - 1, 1, -1 do
      for k = #edges, j + 1, -1 do
        if edges[j] and edges[k] and (edges[j]):same(edges[k]) then
          remove(edges, j)
          remove(edges, k - 1)
        end
      end
    end
    for j = 1, #edges do
      local n = #triangles
      assert(n <= trmax, "Generated more than needed triangles")
      triangles[n + 1] = (Triangle.Create)((edges[j]).p1, (edges[j]).p2, vertices[i])
    end
  end
  for i = #triangles, 1, -1 do
    local triangle = triangles[i]
    if nvertices < (triangle.p1).id or nvertices < (triangle.p2).id or nvertices < (triangle.p3).id then
      remove(triangles, i)
    end
  end
  for _ = 1, 3 do
    remove(vertices)
  end
  do return triangles end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

return Delaunay

