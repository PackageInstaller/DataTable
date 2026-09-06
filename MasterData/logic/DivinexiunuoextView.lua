-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuoextView.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuoextView", package.seeall)

local DivinexiunuoextView = class("DivinexiunuoextView", ViewComponent)

function DivinexiunuoextView:ctor()
	DivinexiunuoextView.super.ctor(self)
end

function DivinexiunuoextView:unbindEvents()
	DivinexiunuoextView.super.unbindEvents(self)
end

function DivinexiunuoextView:bindEvents()
	DivinexiunuoextView.super.bindEvents(self)
end

function DivinexiunuoextView:buildUI()
	DivinexiunuoextView.super.buildUI(self)

	self._cellMap = {}

	for i = 1, 9 do
		self._cellMap[i] = self:getGo("rightTagView/tagCell_" .. i)
	end
end

function DivinexiunuoextView:onExit()
	DivinexiunuoextView.super.onExit(self)
end

function DivinexiunuoextView:onEnter()
	DivinexiunuoextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local groupCfg = DivineXiuNuoConfig.instance:getStageCfgById(self._fmtMo.activityId, self._fmtMo.phaseId, self._fmtMo.stageId) or {}

	self.creepsMasterId = groupCfg.creepsMasterId
	self.creeps = DivineXiuNuoConfig.instance:getCreepsById(self.creepsMasterId) or {}

	for k, v in pairs(self._cellMap) do
		GameUtil.SetActive(v, false)
	end

	for i, v in ipairs(self.creeps) do
		local posId = v.posId
		local go = self._cellMap[posId]

		if go then
			local flag = v.flag

			if not string.nilorempty(flag) then
				GameUtil.SetActive(go, true)

				local txt1 = goutil.findChild(go, "txt_1")
				local txt2 = goutil.findChild(go, "txt_2")

				GameUtil.SetActive(txt1, flag == ConstString.Race[GameEnum.RaceType.Guang])
				GameUtil.SetActive(txt2, flag == ConstString.Race[GameEnum.RaceType.An])
			end
		end
	end
end

return DivinexiunuoextView
