local helper = {}
local Math = require("base.mathx")
local _floor = math.floor
local WIDTH = 36.0
local HEIGHT = 41.0
local WIDTH_SQUARE = WIDTH * WIDTH
local UnitVector_X = UnityVector2(WIDTH, HEIGHT / 2)
local UnitVector_Y = UnityVector2(-WIDTH, HEIGHT / 2)
local UnitVector_Z = UnityVector2(0, -HEIGHT)

function helper.hex_to_position(hex_pos)
  local hex_x = hex_pos[1]
  local hex_y = hex_pos[2]
  local hex_z = hex_pos[3]
  local position_vector2 = hex_x * UnitVector_X + hex_y * UnitVector_Y + hex_z * UnitVector_Z
  return position_vector2
end

function helper.hex_pos_list_to_position_list(hex_pos_list, position_offset)
  position_offset = position_offset or UnityVector2.zero
  local position_list = {}
  for idx, hex_pos in ipairs(hex_pos_list) do
    position_list[idx] = helper.hex_to_position(hex_pos) + position_offset
  end
  return position_list
end

function helper.get_garph_position_list(graph_id, rotate, start_hex)
  local position_offset = start_hex and helper.hex_to_position(start_hex)
  local hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(graph_id, rotate)
  return helper.hex_pos_list_to_position_list(hex_pos_list, position_offset)
end

function helper.get_garph_hex_list(graph_id, rotate, start_hex)
  local hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(graph_id, rotate)
  return helper.move_hex_node_group_to_target(hex_pos_list, start_hex)
end

local function get_distance_square(point1, point2)
  local dx = point2.x - point1.x
  local dy = point2.y - point1.y
  return dx * dx + dy * dy
end

function helper.match_closest_node_idx(map, position_vector2)
  local distance_squared
  for idx, map_vector2 in ipairs(map) do
    distance_squared = get_distance_square(position_vector2, map_vector2)
    if distance_squared < WIDTH_SQUARE then
      return idx
    end
  end
  return nil
end

function helper.move_hex_node_group_to_target(hex_node_group, target_hex_node)
  local result = {}
  local hex_x, hex_y, hex_z
  local target_hex_x, target_hex_y, target_hex_z = target_hex_node[1], target_hex_node[2], target_hex_node[3]
  for idx, hex_pos in ipairs(hex_node_group) do
    hex_x = hex_pos[1] + target_hex_x
    hex_y = hex_pos[2] + target_hex_y
    hex_z = hex_pos[3] + target_hex_z
    result[idx] = {
      hex_x,
      hex_y,
      hex_z
    }
  end
  return result
end

function helper.get_hex_node_group(graph_id, rotate_count)
end

helper.cur_graph_node_group = nil
helper.cur_map = nil
helper.cur_map = nil

function helper.on_drag(graph_id, rotate_count)
end

function helper.on_release(graph_id, rotate_count)
end

function helper.on_rotate(graph_id, rotate_count)
end

function helper.rotate_hex(x, y, z, rotationCount)
  local direction = rotationCount % 6
  local newX, newY, newZ
  if 0 == direction then
    newX, newY, newZ = x, y, z
  elseif direction <= 3 then
    for i = 1, direction do
      newX = -y
      newY = -z
      newZ = -x
      x, y, z = newX, newY, newZ
    end
  else
    direction = 6 - direction
    for i = 1, direction do
      newX = -z
      newY = -x
      newZ = -y
      x, y, z = newX, newY, newZ
    end
  end
  return newX, newY, newZ
end

return helper
