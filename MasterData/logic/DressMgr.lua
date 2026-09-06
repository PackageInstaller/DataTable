-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/DressMgr.lua

module("logic.extensions.dress.DressMgr", package.seeall)

local DressMgr = class("DressMgr")

DressMgr.partTable = {
	[1] = "all",
	[101] = {
		"lanse/zuochi (2)",
		"lanse/youchi (2)"
	}
}

function DressMgr:ctor()
	return
end

function DressMgr:unDressAll(spineChanger)
	local dresses = {}

	for k, v in pairs(DressMgr.partTable) do
		dresses[k] = -1
	end

	self:refreshDresses(dresses, spineChanger)
end

function DressMgr:refreshDresses(dresses, spineChanger)
	for k, v in pairs(dresses) do
		if k == 1 then
			DressMgr.instance:changeDress(k, v, spineChanger)
		end
	end

	for k, v in pairs(dresses) do
		if k ~= 1 then
			DressMgr.instance:changeDress(k, v, spineChanger)
		end
	end
end

function DressMgr:changeDress(partType, id, spineChanger)
	local slotName = DressMgr.partTable[partType]
	local skinName = "luomo"

	if id > 0 then
		skinName = DressConfig.instance:getCfgById(id).skinName
	end

	if slotName == "all" then
		spineChanger:ChangeSkin(skinName)
	else
		local slotList = System.Collections.Generic.List_string.New()

		for i, v in ipairs(slotName) do
			slotList:Add(v)
		end

		spineChanger:ChangeSlots(slotList, skinName)
	end
end

DressMgr.instance = DressMgr.New()

return DressMgr
