-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelPreviewItem.lua

module("logic.extensions.timewheel.view.TimeWheelPreviewItem", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local TimeWheelPreviewItem = class("TimeWheelPreviewItem")

function TimeWheelPreviewItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, TimeWheelPreviewItem)

	component = component or LuaComponentContainer.Add(go, TimeWheelPreviewItem)

	return component
end

function TimeWheelPreviewItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node")
	self._petNum = goutil.findChild(go, "petNum"):GetComponent(goutil.Type_UIText)
end

function TimeWheelPreviewItem:init(data)
	self._petNum.gameObject:SetActive(false)

	if data.rewardType == 1 then
		MaterialMgr.setCellByCfg(data.rewardStr, self._node)
	elseif data.rewardType == 2 then
		local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, self._node)

		proxy.binder:setStars(data.awakeLevel)
		proxy.binder:setLvl(1)

		if data.petNum > 0 then
			self._petNum.gameObject:SetActive(true)

			self._petNum.text = "x" .. data.petNum
		end
	end
end

function TimeWheelPreviewItem:reset()
	MaterialMgr.resetAll(self._node)
end

return TimeWheelPreviewItem
