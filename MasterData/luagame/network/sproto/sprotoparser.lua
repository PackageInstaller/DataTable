local lpeg = require("lpeg")
local table = require("table")
local packbytes, packvalue
if _VERSION == "Lua 5.3" then
  function packbytes(str)
    return string.pack("<s4", str)
  end
  
  function packvalue(id)
    id = (id + 1) * 2
    return string.pack("<I2", id)
  end
else
  function packbytes(str)
    local size = #str
    
    local a = size % 256
    size = math.floor(size / 256)
    local b = size % 256
    size = math.floor(size / 256)
    local c = size % 256
    size = math.floor(size / 256)
    local d = size
    return string.char(a) .. string.char(b) .. string.char(c) .. string.char(d) .. str
  end
  
  function packvalue(id)
    id = (id + 1) * 2
    assert(id >= 0 and id < 65536)
    local a = id % 256
    local b = math.floor(id / 256)
    return string.char(a) .. string.char(b)
  end
end
local P = lpeg.P
local S = lpeg.S
local R = lpeg.R
local C = lpeg.C
local Ct = lpeg.Ct
local Cg = lpeg.Cg
local Cc = lpeg.Cc
local V = lpeg.V

local function count_lines(_, pos, parser_state)
  if pos > parser_state.pos then
    parser_state.line = parser_state.line + 1
    parser_state.pos = pos
  end
  return pos
end

local exception = lpeg.Cmt(lpeg.Carg(1), function(_, pos, parser_state)
  error(string.format("syntax error at [%s] line (%d)", parser_state.file or "", parser_state.line))
  return pos
end)
local eof = P(-1)
local newline = lpeg.Cmt((P("\n") + "\r\n") * lpeg.Carg(1), count_lines)
local line_comment = "#" * (1 - newline) ^ 0 * (newline + eof)
local blank = S(" \t") + newline + line_comment
local blank0 = blank ^ 0
local blanks = blank ^ 1
local alpha = R("az") + R("AZ") + "_"
local alnum = alpha + R("09")
local word = alpha * alnum ^ 0
local name = C(word)
local typename = C(word * ("." * word) ^ 0)
local tag = R("09") ^ 1 / tonumber
local mainkey = "(" * blank0 * name * blank0 * ")"
local decimal = "(" * blank0 * C(tag) * blank0 * ")"

local function multipat(pat)
  return Ct(blank0 * (pat * blanks) ^ 0 * pat ^ 0 * blank0)
end

local function namedpat(name, pat)
  return Ct(Cg(Cc(name), "type") * Cg(pat))
end

local typedef = P({
  "ALL",
  FIELD = namedpat("field", name * blanks * tag * blank0 * ":" * blank0 * C("*") ^ (-1) * typename * (mainkey + decimal) ^ 0),
  STRUCT = P("{") * multipat(V("FIELD") + V("TYPE")) * P("}"),
  TYPE = namedpat("type", P(".") * name * blank0 * V("STRUCT")),
  SUBPROTO = Ct((C("request") + C("response")) * blanks * (typename + V("STRUCT"))),
  PROTOCOL = namedpat("protocol", name * blanks * tag * blank0 * P("{") * multipat(V("SUBPROTO")) * P("}")),
  ALL = multipat(V("TYPE") + V("PROTOCOL"))
})
local proto = blank0 * typedef * blank0
local convert = {}

function convert.protocol(all, obj)
  local result = {
    tag = obj[2]
  }
  for _, p in ipairs(obj[3]) do
    local pt = p[1]
    if nil ~= result[pt] then
      error(string.format("redefine %s in protocol %s", pt, obj[1]))
    end
    local typename = p[2]
    if type(typename) == "table" then
      local struct = typename
      typename = obj[1] .. "." .. p[1]
      all.type[typename] = convert.type(all, {typename, struct})
    end
    if "nil" == typename then
      if "response" == p[1] then
        result.confirm = true
      end
    else
      result[p[1]] = typename
    end
  end
  return result
end

function convert.type(all, obj)
  local result = {}
  local typename = obj[1]
  local tags = {}
  local names = {}
  for _, f in ipairs(obj[2]) do
    if f.type == "field" then
      local name = f[1]
      if names[name] then
        error(string.format("redefine %s in type %s", name, typename))
      end
      names[name] = true
      local tag = f[2]
      if tags[tag] then
        error(string.format("redefine tag %d in type %s", tag, typename))
      end
      tags[tag] = true
      local field = {name = name, tag = tag}
      table.insert(result, field)
      local fieldtype = f[3]
      if "*" == fieldtype then
        field.array = true
        fieldtype = f[4]
      end
      local mainkey = f[5]
      if mainkey then
        if "integer" == fieldtype then
          field.decimal = mainkey
        else
          assert(field.array)
          field.key = mainkey
        end
      end
      field.typename = fieldtype
    else
      assert(f.type == "type")
      local nesttypename = typename .. "." .. f[1]
      f[1] = nesttypename
      assert(all.type[nesttypename] == nil, "redefined " .. nesttypename)
      all.type[nesttypename] = convert.type(all, f)
    end
  end
  table.sort(result, function(a, b)
    return a.tag < b.tag
  end)
  return result
end

local function adjust(r)
  local result = {
    type = {},
    protocol = {}
  }
  for _, obj in ipairs(r) do
    local set = result[obj.type]
    local name = obj[1]
    assert(nil == set[name], "redefined " .. name)
    set[name] = convert[obj.type](result, obj)
  end
  return result
end

local buildin_types = {
  integer = 0,
  boolean = 1,
  string = 2,
  binary = 2,
  double = 3
}

local function checktype(types, ptype, t)
  if buildin_types[t] then
    return t
  end
  local fullname = ptype .. "." .. t
  if types[fullname] then
    return fullname
  else
    ptype = ptype:match("(.+)%..+$")
    if ptype then
      return checktype(types, ptype, t)
    elseif types[t] then
      return t
    end
  end
end

local function check_protocol(r)
  local map = {}
  local type = r.type
  for name, v in pairs(r.protocol) do
    local tag = v.tag
    local request = v.request
    local response = v.response
    local p = map[tag]
    if p then
      error(string.format("redefined protocol tag %d at %s", tag, name))
    end
    if request and not type[request] then
      error(string.format("Undefined request type %s in protocol %s", request, name))
    end
    if response and not type[response] then
      error(string.format("Undefined response type %s in protocol %s", response, name))
    end
    map[tag] = v
  end
  return r
end

local function flattypename(r)
  for typename, t in pairs(r.type) do
    for _, f in pairs(t) do
      local ftype = f.typename
      local fullname = checktype(r.type, typename, ftype)
      if nil == fullname then
        error(string.format("Undefined type %s in type %s", ftype, typename))
      end
      f.typename = fullname
    end
  end
  return r
end

local function parser(text, filename)
  local state = {
    file = filename,
    pos = 0,
    line = 1
  }
  local r = lpeg.match(proto * -1 + exception, text, 1, state)
  return flattypename(check_protocol(adjust(r)))
end

local function packfield(f)
  local strtbl = {}
  if f.array then
    if f.key then
      table.insert(strtbl, "\006\000")
    else
      table.insert(strtbl, "\005\000")
    end
  else
    table.insert(strtbl, "\004\000")
  end
  table.insert(strtbl, "\000\000")
  if f.buildin then
    table.insert(strtbl, packvalue(f.buildin))
    if f.extra then
      table.insert(strtbl, packvalue(f.extra))
    else
      table.insert(strtbl, "\001\000")
    end
    table.insert(strtbl, packvalue(f.tag))
  else
    table.insert(strtbl, "\001\000")
    table.insert(strtbl, packvalue(f.type))
    table.insert(strtbl, packvalue(f.tag))
  end
  if f.array then
    table.insert(strtbl, packvalue(1))
  end
  if f.key then
    table.insert(strtbl, packvalue(f.key))
  end
  table.insert(strtbl, packbytes(f.name))
  return packbytes(table.concat(strtbl))
end

local function packtype(name, t, alltypes)
  local fields = {}
  local tmp = {}
  for _, f in ipairs(t) do
    tmp.array = f.array
    tmp.name = f.name
    tmp.tag = f.tag
    tmp.extra = f.decimal
    tmp.buildin = buildin_types[f.typename]
    if f.typename == "binary" then
      tmp.extra = 1
    end
    local subtype
    if not tmp.buildin then
      subtype = assert(alltypes[f.typename])
      tmp.type = subtype.id
    else
      tmp.type = nil
    end
    if f.key then
      tmp.key = subtype.fields[f.key]
      if not tmp.key then
        error("Invalid map index :" .. f.key)
      end
    else
      tmp.key = nil
    end
    table.insert(fields, packfield(tmp))
  end
  local data
  if 0 == #fields then
    data = {
      "\001\000",
      "\000\000",
      packbytes(name)
    }
  else
    data = {
      "\002\000",
      "\000\000",
      "\000\000",
      packbytes(name),
      packbytes(table.concat(fields))
    }
  end
  return packbytes(table.concat(data))
end

local function packproto(name, p, alltypes)
  if p.request then
    local request = alltypes[p.request]
    if nil == request then
      error(string.format("Protocol %s request type %s not found", name, p.request))
    end
    request = request.id
  end
  local tmp = {
    "\004\000",
    "\000\000",
    packvalue(p.tag)
  }
  if p.request == nil and nil == p.response and nil == p.confirm then
    tmp[1] = "\002\000"
  else
    if p.request then
      table.insert(tmp, packvalue(alltypes[p.request].id))
    else
      table.insert(tmp, "\001\000")
    end
    if p.response then
      table.insert(tmp, packvalue(alltypes[p.response].id))
    elseif p.confirm then
      tmp[1] = "\005\000"
      table.insert(tmp, "\001\000")
      table.insert(tmp, packvalue(1))
    else
      tmp[1] = "\003\000"
    end
  end
  table.insert(tmp, packbytes(name))
  return packbytes(table.concat(tmp))
end

local function packgroup(t, p)
  if next(t) == nil then
    assert(next(p) == nil)
    return "\000\000"
  end
  local tt, tp
  local alltypes = {}
  for name in pairs(t) do
    table.insert(alltypes, name)
  end
  table.sort(alltypes)
  for idx, name in ipairs(alltypes) do
    local fields = {}
    for _, type_fields in ipairs(t[name]) do
      if buildin_types[type_fields.typename] then
        fields[type_fields.name] = type_fields.tag
      end
    end
    alltypes[name] = {
      id = idx - 1,
      fields = fields
    }
  end
  tt = {}
  for _, name in ipairs(alltypes) do
    table.insert(tt, packtype(name, t[name], alltypes))
  end
  tt = packbytes(table.concat(tt))
  if next(p) then
    local tmp = {}
    for name, tbl in pairs(p) do
      table.insert(tmp, tbl)
      tbl.name = name
    end
    table.sort(tmp, function(a, b)
      return a.tag < b.tag
    end)
    tp = {}
    for _, tbl in ipairs(tmp) do
      table.insert(tp, packproto(tbl.name, tbl, alltypes))
    end
    tp = packbytes(table.concat(tp))
  end
  local result
  if nil == tp then
    result = {
      "\001\000",
      "\000\000",
      tt
    }
  else
    result = {
      "\002\000",
      "\000\000",
      "\000\000",
      tt,
      tp
    }
  end
  return table.concat(result)
end

local function encodeall(r)
  return packgroup(r.type, r.protocol)
end

local sparser = {}

function sparser.dump(str)
  local tmp = ""
  for i = 1, #str do
    tmp = tmp .. string.format("%02X ", string.byte(str, i))
    if 0 == i % 8 then
      if 0 == i % 16 then
        print(tmp)
        tmp = ""
      else
        tmp = tmp .. "- "
      end
    end
  end
  print(tmp)
end

function sparser.parse(text, name)
  local r = parser(text, name or "=text")
  local data = encodeall(r)
  return data
end

return sparser
