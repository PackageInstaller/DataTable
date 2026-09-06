-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/express/ExpressParser.lua

module("logiccommon.common.express.ExpressParser", package.seeall)

local ExpressParser = {}
local NODE_CONST = "const"
local NODE_ATOM = "atom"
local NODE_NOT = "not"
local NODE_AND = "and"
local NODE_OR = "or"
local TOKEN_ATOM = "atom"
local _isBlank, _tokenize, _newParser, _peek, _parseOr

function ExpressParser.parse(expressStr, atomFactory)
	if _isBlank(expressStr) then
		return {
			value = true,
			type = NODE_CONST
		}
	end

	local tokens, err = _tokenize(expressStr)

	if tokens == nil then
		return nil, err
	end

	local parser = _newParser(tokens, atomFactory)
	local node, err = _parseOr(parser)

	if node == nil then
		return nil, err
	end

	local token = _peek(parser)

	if token ~= nil then
		return nil, string.format("表达式符号 '%s' 位置不正确", token.value)
	end

	return node
end

function ExpressParser.eval(node, context)
	if node == nil then
		return false
	end

	if node.type == NODE_CONST then
		return node.value == true
	elseif node.type == NODE_ATOM then
		if type(node.atom) == "table" and node.atom.cal then
			return node.atom.cal(context) == true
		elseif type(node.atom) == "function" then
			return node.atom(context) == true
		end

		return false
	elseif node.type == NODE_NOT then
		return not ExpressParser.eval(node.expr, context)
	elseif node.type == NODE_AND then
		return ExpressParser.eval(node.left, context) and ExpressParser.eval(node.right, context)
	elseif node.type == NODE_OR then
		return ExpressParser.eval(node.left, context) or ExpressParser.eval(node.right, context)
	end

	return false
end

local function _trim(str)
	str = str or ""

	return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

function _isBlank(str)
	return str == nil or _trim(str) == ""
end

local function _isSpace(c)
	return c == " " or c == "\t" or c == "\r" or c == "\n"
end

local function _newToken(tokenType, value)
	return {
		type = tokenType,
		value = value
	}
end

function _tokenize(expressStr)
	local tokens = {}
	local index = 1
	local len = string.len(expressStr)

	while index <= len do
		local c = string.sub(expressStr, index, index)

		if _isSpace(c) then
			index = index + 1
		elseif c == "!" or c == "&" or c == "|" or c == "(" or c == ")" then
			table.insert(tokens, _newToken(c, c))

			index = index + 1
		else
			local beginIndex = index

			while index <= len do
				c = string.sub(expressStr, index, index)

				if c == "&" or c == "|" or c == "(" or c == ")" then
					break
				end

				if c == "!" and string.sub(expressStr, index + 1, index + 1) ~= "=" then
					break
				end

				index = index + 1
			end

			local atomStr = _trim(string.sub(expressStr, beginIndex, index - 1))

			if atomStr == "" then
				return nil, "表达式原子为空"
			end

			table.insert(tokens, _newToken(TOKEN_ATOM, atomStr))
		end
	end

	return tokens
end

function _newParser(tokens, atomFactory)
	local parser = {}

	parser._atomFactory = atomFactory
	parser._index = 1
	parser._tokens = tokens or {}
	parser._len = #parser._tokens

	return parser
end

function _peek(parser)
	if parser._index > parser._len then
		return nil
	end

	return parser._tokens[parser._index]
end

local function _consume(parser)
	local token = _peek(parser)

	if token ~= nil then
		parser._index = parser._index + 1
	end

	return token
end

local function _parseAtom(parser)
	local token = _consume(parser)

	if token then
		if not token.value then
			local atomStr = ""

			if atomStr == "" then
				return nil, "表达式原子为空"
			end

			local atom = atomStr

			if parser._atomFactory then
				local err

				atom, err = parser._atomFactory(atomStr)

				if atom == nil then
					return nil, err or string.format("表达式原子无效：%s", atomStr)
				end
			end

			return {
				type = NODE_ATOM,
				atom = atom
			}
		end
	end
end

local function _parsePrimary(parser)
	local token = _peek(parser)

	if token == nil then
		return nil, "表达式不完整：缺少条件或右括号"
	end

	if token.value == "(" then
		_consume(parser)

		local node, err = _parseOr(parser)

		if node == nil then
			return nil, err
		end

		token = _peek(parser)

		if token == nil or token.value ~= ")" then
			return nil, "括号不匹配：'(' 缺少对应的 ')'"
		end

		_consume(parser)

		return node
	end

	if token.value == ")" then
		return nil, "括号不匹配：多余的 ')'"
	end

	if token.value == "&" or token.value == "|" then
		return nil, string.format("表达式运算符 '%s' 前缺少条件", token.value)
	end

	if token.type ~= TOKEN_ATOM then
		return nil, string.format("表达式符号 '%s' 位置不正确", token.value)
	end

	return _parseAtom(parser)
end

local function _parseUnary(parser)
	local reverse = false

	while _peek(parser) ~= nil and _peek(parser).value == "!" do
		reverse = not reverse

		_consume(parser)
	end

	local node, err = _parsePrimary(parser)

	if node == nil then
		return nil, err
	end

	if reverse then
		return {
			type = NODE_NOT,
			expr = node
		}
	end

	return node
end

local function _parseAnd(parser)
	local node, err = _parseUnary(parser)

	if node == nil then
		return nil, err
	end

	while _peek(parser) ~= nil and _peek(parser).value == "&" do
		_consume(parser)

		local right

		right, err = _parseUnary(parser)

		if right == nil then
			return nil, err
		end

		node = {
			type = NODE_AND,
			left = node,
			right = right
		}
	end

	return node
end

function _parseOr(parser)
	local node, err = _parseAnd(parser)

	if node == nil then
		return nil, err
	end

	while _peek(parser) ~= nil and _peek(parser).value == "|" do
		_consume(parser)

		local right

		right, err = _parseAnd(parser)

		if right == nil then
			return nil, err
		end

		node = {
			type = NODE_OR,
			left = node,
			right = right
		}
	end

	return node
end

return ExpressParser
