-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Tools\\TablePickle.lua

local TablePickle = {}

TablePickle._tempTableToRef = nil
TablePickle._tempRefToTable = nil

function TablePickle.pickle(tbl)
	if type(tbl) ~= "table" then
		error(type(tbl) .. " can not be pickled, table only.")
	end

	TablePickle._tempTableToRef = {}
	TablePickle._tempRefToTable = {}

	local saveCount = 0

	TablePickle.ref(tbl)

	local retTbl = {
		"{"
	}

	while saveCount < table.getn(TablePickle._tempRefToTable) do
		saveCount = saveCount + 1

		local t = TablePickle._tempRefToTable[saveCount]

		table.insert(retTbl, "{\n")

		for i, v in pairs(t) do
			table.insert(retTbl, "[")
			TablePickle.value(i, retTbl)
			table.insert(retTbl, "]=")
			TablePickle.value(v, retTbl)
			table.insert(retTbl, ",\n")
		end

		table.insert(retTbl, "},\n")
	end

	table.insert(retTbl, "}")

	return table.concat(retTbl)
end

function TablePickle.value(v, retTbl)
	local vtype = type(v)

	if vtype == "string" then
		table.insert(retTbl, string.format("%q", v))
	elseif vtype == "number" then
		table.insert(retTbl, v)
	elseif vtype == "boolean" then
		table.insert(retTbl, tostring(v))
	elseif vtype == "table" then
		table.insert(retTbl, "{")
		table.insert(retTbl, TablePickle.ref(v))
		table.insert(retTbl, "}")
	end
end

function TablePickle.ref(tbl)
	local ref = TablePickle._tempTableToRef[tbl]

	if not ref then
		if tbl == TablePickle then
			error("You should not picke the TablePickle class!")
		end

		table.insert(TablePickle._tempRefToTable, tbl)

		ref = table.getn(TablePickle._tempRefToTable)
		TablePickle._tempTableToRef[tbl] = ref
	end

	return ref
end

function TablePickle.unpickle(s)
	if type(s) ~= "string" then
		error("can't unpickle a " .. type(s) .. ", only strings")
	end

	local gentables = loadstring("return " .. s)
	local tables = gentables()

	for tnum = 1, table.getn(tables) do
		local t = tables[tnum]
		local tcopy = {}

		for i, v in pairs(t) do
			tcopy[i] = v
		end

		for i, v in pairs(tcopy) do
			local ni, nv

			if type(i) == "table" then
				ni = tables[i[1]]
			else
				ni = i
			end

			if type(v) == "table" then
				nv = tables[v[1]]
			else
				nv = v
			end

			t[i] = nil
			t[ni] = nv
		end
	end

	return tables[1]
end

return TablePickle
