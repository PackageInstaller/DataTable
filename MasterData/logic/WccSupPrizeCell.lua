-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WccSupPrizeCell.lua

module("logic.extensions.wisdomcourageclg.view.WccSupPrizeCell", package.seeall)

local WccSupPrizeCell = class("WccSupPrizeCell")

function WccSupPrizeCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._txtScore = goutil.findChildTextComponent(go, "txtScore")
	self._item = goutil.findChild(go, "item")
	self._canGet = goutil.findChild(go, "canGet")
	self._geted = goutil.findChild(go, "geted")
end

function WccSupPrizeCell:getGo()
	return self.mainGO
end

function WccSupPrizeCell:init(data, view, rectTrans)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._txtScore.text = string.format("第%s关", data.stageId)

	local matType, id, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.resetAll(self._item)

	local proxy = MaterialMgr.setCellByCfg(data.prize, self._item)

	self:update()
end

function WccSupPrizeCell:update()
	local mo = WisdomCourageClgController.instance:getWisdomCourageClgMo(self._data.activityId)
	local isGeted = mo:isPassStageInSupport(self._data.stageId)

	goutil.setActive(self._geted, isGeted)
end

function WccSupPrizeCell:clear()
	MaterialMgr.resetAll(self._item)
end

return WccSupPrizeCell
