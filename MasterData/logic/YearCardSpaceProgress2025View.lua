-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardSpaceProgress2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardSpaceProgress2025View", package.seeall)

local YearCardSpaceProgress2025View = class("YearCardSpaceProgress2025View", YearCardSpaceProgress2023View)

function YearCardSpaceProgress2025View:buildUI()
	YearCardSpaceProgress2025View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2025", true)
end

function YearCardSpaceProgress2025View:onEnter()
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

return YearCardSpaceProgress2025View
