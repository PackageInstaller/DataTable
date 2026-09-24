if _G.module ~= nil then
	_G.module = nil
end

if table.unpack == nil then
	table.unpack = _G.unpack
	_G.unpack = nil
end
