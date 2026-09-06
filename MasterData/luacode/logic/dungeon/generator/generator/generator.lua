local Generator = class("Generator")
local SpatialAStar = require("logic.dungeon.pathfinding.spatialastar")
local Region = require("logic.dungeon.generator.generator.region")
local Rect = require("logic.dungeon.generator.generator.rect")
local Packer = require("logic.dungeon.generator.generator.packer")
local MazeGenerator = require("logic.dungeon.generator.generator.mazegenerator")
local Delaunay = require("logic.dungeon.generator.delaunay-triangulation.delaunay")
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local Graph = require("logic.dungeon.generator.prim.graph")
local Prim = require("logic.dungeon.generator.prim.prim")
local legal_move_dirs = {
  Point.Create(1, 0),
  Point.Create(-1, 0),
  Point.Create(0, 1),
  Point.Create(0, -1)
}
local direct_neighbor_dir = {
  {
    dir = Point.Create(1, 0),
    id = 4
  },
  {
    dir = Point.Create(-1, 0),
    id = 6
  },
  {
    dir = Point.Create(0, 1),
    id = 2
  },
  {
    dir = Point.Create(0, -1),
    id = 8
  }
}
local indirect_neighbor_dir = {
  {
    dir = Point.Create(1, 1),
    id = 1
  },
  {
    dir = Point.Create(-1, 1),
    id = 3
  },
  {
    dir = Point.Create(-1, -1),
    id = 9
  },
  {
    dir = Point.Create(1, -1),
    id = 7
  }
}
local illegal_corner_rel_pos = {
  Point.Create(1, 2),
  Point.Create(-1, -2),
  Point.Create(1, -2),
  Point.Create(-1, 2),
  Point.Create(2, 1),
  Point.Create(-2, 1),
  Point.Create(2, -1),
  Point.Create(-2, -1),
  Point.Create(2, 2),
  Point.Create(2, -2),
  Point.Create(-2, -2),
  Point.Create(-2, 2)
}

function Generator:Ctor(width, height, mininterval, config)
  self._width = width
  self._height = height
  self._mininterval = mininterval
  self._config = config
  self.rooms = {}
end

function Generator:Generate()
  self:pack_enlarged_rooms()
  local mst = self:gen_edges()
  local paths = self:connect_doors(mst)
  self:remove_irregulars(paths)
  self:add_walls(paths)
end

function Generator:pack_enlarged_rooms()
  local random = pcg.create()
  self.rooms = {}
  local calculated_size = self._width == 0 and self._height == 0
  for k, v in pairs(self._config) do
    for i = 1, v do
      table.insert(self.rooms, clone(k))
    end
    if calculated_size then
      local max = math.max(1, v / 2)
      self._width = self._width + k:GetArea():GetWidth() * max + max / 2 * random(5, 10)
      self._height = self._height + k:GetArea():GetHeight() * max + max / 2 * random(5, 10)
    end
  end
  for i, v in ipairs(self.rooms) do
    v:SetID(i)
  end
  local packer = Packer.Create(self._mininterval)
  packer:Pack(self.rooms, self._width, self._height)
  self._area = Region.Create(self._width, self._height)
  self._mazeGenerator = MazeGenerator.Create(self._area)
  for _, v in ipairs(self.rooms) do
    self._area:FillRect(v:GetArea(), Region.BlockingType.Room, v:GetID())
  end
  table.sort(self.rooms, function(lhs, rhs)
    return lhs:GetID() < rhs:GetID()
  end)
end

local function abstract_edges(rooms, triangles)
  local edges = {}
  for _, t in ipairs(triangles) do
    local e1, e2, e3 = t.e1, t.e2, t.e3
    if not table.any(edges, function(k, e)
      return e:same(e1)
    end) then
      table.insert(edges, e1)
    end
    if not table.any(edges, function(k, e)
      return e:same(e2)
    end) then
      table.insert(edges, e2)
    end
    if not table.any(edges, function(k, e)
      return e:same(e3)
    end) then
      table.insert(edges, e3)
    end
  end
  return edges
end

function Generator:gen_edges()
  local points = self:gen_points()
  local triangles = Delaunay.triangulate(table.unpack(points))
  return self:gen_mst(abstract_edges(self.rooms, triangles))
end

function Generator:gen_points()
  local result = {}
  for k, v in ipairs(self.rooms) do
    table.insert(result, Point.Create(v:GetArea():GetPosition()))
  end
  return result
end

local function find_room(rooms, pt)
  for k, v in pairs(rooms) do
    local x, y = v:GetArea():GetPosition()
    if x == pt.x and y == pt.y then
      return v
    end
  end
end

function Generator:gen_mst(edges)
  local mst = {}
  local init = {}
  for i = 1, #self.rooms do
    table.insert(init, i)
  end
  local graph = Graph.Create(init)
  local start_node
  for _, v in ipairs(edges) do
    local p1 = find_room(self.rooms, v.p1):GetID()
    local p2 = find_room(self.rooms, v.p2):GetID()
    graph:SetEdge(p1, p2, v.p1:dist2(v.p2))
    start_node = start_node or p1
  end
  local result = Prim.prim(graph, start_node)
  for k, v in pairs(result) do
    table.insert(mst, {
      math.min(k._context, v._context),
      math.max(k._context, v._context)
    })
  end
  table.sort(mst, function(lhs, rhs)
    if lhs[1] < rhs[1] then
      return true
    elseif lhs[1] == rhs[1] then
      return lhs[2] < rhs[2]
    else
      return false
    end
  end)
  return mst
end

local meta = {
  __index = function(table, key)
    for k, v in pairs(table) do
      if k == key then
        return v
      end
    end
  end,
  __newindex = function(table, key, value)
    for k, v in pairs(table) do
      if k == key then
        rawset(table, k, value)
        return
      end
    end
    rawset(table, key, value)
  end
}

local function create_hashset()
  local t = {}
  setmetatable(t, meta)
  return t
end

local function copy_hashset(source)
  local t = clone(source)
  setmetatable(t, meta)
  return t
end

function Generator:connect_doors(mst)
  local paths = create_hashset()
  for _, v in ipairs(mst) do
    print(v[1], v[2])
    local _, lhs = table.first(self.rooms, function(key, value)
      return value:GetID() == v[1]
    end)
    local _, rhs = table.first(self.rooms, function(key, value)
      return value:GetID() == v[2]
    end)
    local area, ldoor, rdoor, ldir, rdir = self:gen_maze_area(lhs, rhs)
    print("  ", lhs:GetID(), ldoor, ldir)
    print("  ", rhs:GetID(), rdoor, rdir)
    local pos = Point.Create(math.min(ldoor.x, rdoor.x), math.min(ldoor.y, rdoor.y))
    self._mazeGenerator:Clear()
    self._mazeGenerator:Init(Rect.Create(pos.x, pos.y, area:GetWidth(), area:GetHeight()), ldoor:Advance(ldir), rdoor:Advance(rdir))
    local path = self._mazeGenerator:Generate(0)
    for _, v in pairs(path) do
      paths[v] = true
    end
    paths[ldoor] = true
    paths[rdoor] = true
    self._area:Fill(ldoor.x, ldoor.y, Region.BlockingType.Floor, 0)
    self._area:Fill(rdoor.x, rdoor.y, Region.BlockingType.Floor, 0)
  end
  return paths
end

function Generator:gen_maze_area(lhs_room, rhs_room)
  local min = math.maxinteger
  local tmp
  local lhs_doors = lhs_room:GetAllDoors()
  _, tmp = table.first(lhs_doors)
  local ldir = tmp.dir
  local ldoor = clone(tmp.center)
  local rhs_doors = rhs_room:GetAllDoors()
  _, tmp = table.first(rhs_doors)
  local rdir = tmp.dir
  local rdoor = clone(tmp.center)
  for _, ld in ipairs(lhs_doors) do
    for _, rd in ipairs(rhs_doors) do
      local dist2 = ld.center:dist2(rd.center)
      if min > dist2 then
        ldir = ld.dir
        rdir = rd.dir
        ldoor = clone(ld.center)
        rdoor = clone(rd.center)
        min = dist2
      end
    end
  end
  lhs_room:OpenDoor(ldir, ldoor)
  rhs_room:OpenDoor(rdir, rdoor)
  local x, y = lhs_room:GetArea():GetMin()
  ldoor.x = ldoor.x + x
  ldoor.y = ldoor.y + y
  ldoor = ldoor:Advance(ldir)
  x, y = rhs_room:GetArea():GetMin()
  rdoor.x = rdoor.x + x
  rdoor.y = rdoor.y + y
  rdoor = rdoor:Advance(rdir)
  local width = math.abs(ldoor.x - rdoor.x) + 1
  local height = math.abs(ldoor.y, rdoor.y) + 1
  return Region.Create(width, height), ldoor, rdoor, ldir, rdir
end

function Generator:remove_irregulars(path)
  self:remove_channel(path)
  self:remove_l_corner(path)
end

local function traverse(pt, last_dir, paths, corners)
  paths[pt] = nil
  for _, dir in ipairs(legal_move_dirs) do
    local candidate = pt + dir
    if paths[candidate] and last_dir ~= dir then
      corners[pt] = true
      traverse(candidate, dir * -1, paths, corners)
    end
  end
end

local function sign(n)
  if 0 < n then
    return 1
  elseif n < 0 then
    return -1
  elseif n == 0 then
    return 0
  end
end

function Generator:remove_l_corner(path)
  local corners = create_hashset()
  for _, room in ipairs(self.rooms) do
    local x, y = room:GetArea():GetPosition()
    local doors = room:GetOpenDoors()
    for k, v in pairs(doors) do
      doors[k] = v.center:Advance(v.dir)
      doors[k].x = doors[k].x + x
      doors[k].y = doors[k].y + y
      traverse(doors[k], Point.Create(0, 0), copy_hashset(path), corners)
      corners[doors[k]] = nil
    end
  end
  local new_paths = create_hashset()
  for corner, _ in pairs(corners) do
    for _, dir in ipairs(illegal_corner_rel_pos) do
      if corners[corner + dir] then
        local pt = clone(corner)
        pt.x = pt.x + sign(dir.x)
        local cell = self._area:Get(pt.x, pt.y)
        if cell.type ~= Region.BlockingType.Empty and self._mazeGenerator:IsWalkable(cell) then
          new_paths[pt] = true
          self._area:Fill(pt.x, pt.y, Region.BlockingType.Floor, 0)
        end
        pt = clone(corner)
        pt.y = pt.y + sign(dir.y)
        cell = self._area:Get(pt.x, pt.y)
        if cell.type ~= Region.BlockingType.Empty and self._mazeGenerator:IsWalkable(cell) then
          new_paths[pt] = true
          self._area:Fill(pt.x, pt.y, Region.BlockingType.Floor, 0)
        end
      end
    end
  end
  for k, v in pairs(new_paths) do
    path[k] = true
  end
end

function Generator:remove_channel(path)
  local new_path = create_hashset()
  for pt, _ in pairs(path) do
    for _, dir in ipairs(legal_move_dirs) do
      if path[pt + dir * 2] then
        local candidate = pt + dir
        if self._area:Get(candidate.x, candidate.y).type == Region.BlockingType.Empty then
          new_path[candidate] = true
          self._area:Fill(candidate.x, candidate.y, Region.BlockingType.Floor, 0)
        end
      end
    end
  end
  for k, v in pairs(new_path) do
    path[k] = true
  end
end

function Generator:add_walls(paths)
  local dirs = clone(direct_neighbor_dir)
  for k, v in ipairs(indirect_neighbor_dir) do
    table.insert(dirs, v)
  end
  for pt, _ in pairs(paths) do
    for _, v in ipairs(dirs) do
      local wall = pt + v.dir
      if self._area:Inside(wall.x, wall.y) and self._area:Get(wall.x, wall.y).type == Region.BlockingType.Empty then
        self:check_empty(paths, wall)
      end
    end
  end
end

function Generator:check_empty(paths, wall)
  local direct_neighbor = create_hashset()
  local indirect_neighbor = create_hashset()
  for _, v in ipairs(direct_neighbor_dir) do
    if paths[wall + v.dir] then
      direct_neighbor[v.dir] = true
    end
  end
  for _, v in ipairs(indirect_neighbor_dir) do
    if paths[wall + v.dir] then
      indirect_neighbor[v.dir] = true
    end
  end
  local count = table.nums(direct_neighbor)
  if count == 0 then
    local dir = table.first(indirect_neighbor)
    local id
    for _, v in ipairs(indirect_neighbor_dir) do
      if v.dir == dir then
        id = v.id
        break
      end
    end
    self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, id)
  elseif count == 1 then
    local dir = table.first(direct_neighbor)
    local id
    for _, v in ipairs(direct_neighbor_dir) do
      if v.dir == dir then
        id = v.id
        break
      end
    end
    self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, id)
  elseif count == 2 then
    if direct_neighbor[legal_move_dirs[3]] then
      if direct_neighbor[legal_move_dirs[2]] then
        self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, 17)
      elseif direct_neighbor[legal_move_dirs[1]] then
        self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, 11)
      else
        assert(false)
      end
    elseif direct_neighbor[legal_move_dirs[4]] then
      if direct_neighbor[legal_move_dirs[2]] then
        self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, 16)
      elseif direct_neighbor[legal_move_dirs[1]] then
        self._area:Fill(wall.x, wall.y, Region.BlockingType.Blocking, 15)
      else
        assert(false)
      end
    end
  else
    self._area:Fill(wall.x, wall.y, Region.BlockingType.Floor, 0)
    paths[wall] = true
  end
end

return Generator
