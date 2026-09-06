-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardSignin2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardSignin2024View", package.seeall)

local YearCardSignin2024View = class("YearCardSignin2024View", YearCardSignin2023View)

function YearCardSignin2024View:ctor()
	YearCardSignin2024View.super.ctor(self)

	self.skinId = 18001
end

function YearCardSignin2024View:buildUI()
	YearCardSignin2024View.super.buildUI(self)

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
end

function YearCardSignin2024View:onEnter()
	YearCardSignin2024View.super.onEnter(self)
	self._yearCardChangeRole:onEnter()
end

function YearCardSignin2024View:onExit()
	YearCardSignin2024View.super.onExit(self)
	self._yearCardChangeRole:onExit()
end

return YearCardSignin2024View
