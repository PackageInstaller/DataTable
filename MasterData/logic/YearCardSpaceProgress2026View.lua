-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardSpaceProgress2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardSpaceProgress2026View", package.seeall)

local YearCardSpaceProgress2026View = class("YearCardSpaceProgress2026View", YearCardSpaceProgress2023View)

function YearCardSpaceProgress2026View:buildUI()
	YearCardSpaceProgress2026View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2026", true)
end

function YearCardSpaceProgress2026View:onEnter()
	YearCardSpaceProgress2023View.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()

	YearCardController.instance:getUserAnnuityInfo()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)
	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name
	self._progressCfgs = YearCardConfig.instance:getSpaceProgressPrizeCfgs(self._curActId)
	self._curActive = YearCardModel.instance:isActiveAnnuity(self._curActId)
	self._curAmout = 0
	self._hasGainPrizeIds = {}
	self._prizeCfg = YearCardConfig.instance:getSpaceProgressPrizeCfgs(self._curActId)
	self._txtAmout.text = langPara("%s", 0)

	self:_initPlayerParams()
end

function YearCardSpaceProgress2026View:_getActId()
	return YearCardConfig.instance:getNextActId()
end

return YearCardSpaceProgress2026View
