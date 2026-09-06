-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPerWeek2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPerWeek2024View", package.seeall)

local YearCardPerWeek2024View = class("YearCardPerWeek2024View", YearCardPerWeek2023View)

function YearCardPerWeek2024View:ctor()
	YearCardPerWeek2024View.super.ctor(self)

	self._curPrizeNum = 8
end

function YearCardPerWeek2024View:buildUI()
	YearCardPerWeek2024View.super.buildUI(self)

	self.skinId = 18001
	self._petCon2Raw = self:getGo("bg/petCon2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_1Raw = self:getGo("bg/petCon1_1"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_2Raw = self:getGo("bg/petCon1_1/petCon1_2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._roleList = {
		{
			skinId = 18001,
			rawImgs = {
				self._petCon1_1Raw,
				self._petCon1_2Raw
			}
		},
		[0] = {
			skinId = 14022,
			rawImgs = {
				self._petCon2Raw
			}
		}
	}
	self._yearCardChangeRole = YearCardChangeRole.New()

	self._yearCardChangeRole:setData(self._roleList)
	self._yearCardChangeRole:setTxtName(self._txtName)
	self._yearCardChangeRole:setView(self)

	self._getedGo = self:getGo("reward/geted")
end

function YearCardPerWeek2024View:onExit()
	YearCardPerWeek2024View.super.onExit(self)
	self._yearCardChangeRole:onExit()
end

function YearCardPerWeek2024View:onEnter()
	YearCardPerWeek2024View.super.onEnter(self)
	self._yearCardChangeRole:onEnter()
end

function YearCardPerWeek2024View:_refreshGetState(hasGain)
	GameUtil.SetActive(self._btnSure, not hasGain)
	GameUtil.SetActive(self._getedGo, hasGain)
end

return YearCardPerWeek2024View
