-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgFmtView.lua

module("logic.extensions.originasheclg.view.OriginAsheClgFmtView", package.seeall)

local OriginAsheClgFmtView = class("OriginAsheClgFmtView", ViewComponent)

function OriginAsheClgFmtView:ctor()
	OriginAsheClgFmtView.super.ctor(self)
end

function OriginAsheClgFmtView:unbindEvents()
	OriginAsheClgFmtView.super.unbindEvents(self)
end

function OriginAsheClgFmtView:bindEvents()
	OriginAsheClgFmtView.super.bindEvents(self)
end

function OriginAsheClgFmtView:buildUI()
	OriginAsheClgFmtView.super.buildUI(self)

	self._formation = self:getGo("formation")
	self._petList = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._formation, "pos_" .. i)

		self._petList[i] = {
			go = go,
			txt = goutil.findChildTextComponent(go, "txt")
		}
	end
end

function OriginAsheClgFmtView:onExit()
	OriginAsheClgFmtView.super.onExit(self)
end

function OriginAsheClgFmtView:onEnter()
	OriginAsheClgFmtView.super.onEnter(self)

	local fmtMo = self:getFirstParam()
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(fmtMo.activityId, fmtMo.stageId)
	local hpMap = {}

	if stageInfo and stageInfo.info.hpWanPercent then
		for i, v in ipairs(stageInfo.info.hpWanPercent) do
			hpMap[v.left] = v.right
		end
	end

	for i = 1, 9 do
		GameUtil.SetActive(self._petList[i].go, false)
	end

	for i, v in ipairs(fmtMo:getMonsterConfigList()) do
		if self._petList[v.posId] then
			if hpMap[v.creepsId] then
				if hpMap[v.creepsId] > 0 then
					GameUtil.SetActive(self._petList[v.posId].go, true)

					self._petList[v.posId].txt.text = string.format("%.0f%%", math.ceil(hpMap[v.creepsId] / 100))
				else
					GameUtil.SetActive(self._petList[v.posId].go, false)
				end
			else
				GameUtil.SetActive(self._petList[v.posId].go, true)

				self._petList[v.posId].txt.text = "100%"
			end
		end
	end
end

return OriginAsheClgFmtView
