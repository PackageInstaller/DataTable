-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneSuitItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(type, cid, num)
	local isEmpty = type == nil or type == 1 and cid == nil

	self.View:SetActive(not isEmpty)

	if isEmpty then
		return
	end

	local name

	if type == 1 then
		local cfgRuneConstituteData = CfgRuneConstituteTable[cid]

		name = cfgRuneConstituteData.Name
	else
		name = ""
	end

	AssetUtil.LoadImage(self, EndlessMazeRuneMainUIApi:GetString("SuitItemBg", type), self.View:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	UGUIUtil.SetTextInChildren(self.View, EndlessMazeRuneMainUIApi:GetString("SuitItemText", type, name, num))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
