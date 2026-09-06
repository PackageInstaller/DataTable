-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardSpaceProgress2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardSpaceProgress2023View", package.seeall)

local YearCardSpaceProgress2023View = class("YearCardSpaceProgress2023View", ViewComponent)

function YearCardSpaceProgress2023View:buildUI()
	YearCardSpaceProgress2023View.super.buildUI(self)

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtAmout = goutil.findChildTextComponent(playerRoot, "progress/txtProgress")
	self.skinId = 16010
	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
end

function YearCardSpaceProgress2023View:bindEvents()
	YearCardSpaceProgress2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function YearCardSpaceProgress2023View:unbindEvents()
	YearCardSpaceProgress2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function YearCardSpaceProgress2023View:onEnter()
	YearCardSpaceProgress2023View.super.onEnter(self)

	self._curActId = self:_getActId()

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

	self._url = GameUrl.getSpineUIUrl("20020_maomao")

	getres(self._url, self._onResloadFinish, self, ResType.AssetBundle, true)
end

function YearCardSpaceProgress2023View:onExit()
	YearCardSpaceProgress2023View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)
	MaterialMgr.resetAll(self._rare)
	self._playerSliderMo:onExit()

	if self._url then
		removeresl(self._url, self._onResloadFinish, self)

		self._url = nil
	end

	if self._res then
		self._res:Release()

		self._res = nil
	end
end

function YearCardSpaceProgress2023View:_getActId()
	return YearCardModel.instance:getCurAnnuityId()
end

function YearCardSpaceProgress2023View:_refreshViewByInfo()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	if self._actInfo then
		self._curAmout = self._actInfo.activeCount
		self._hasGainPrizeIds = self._actInfo.gainedSpaceProgressPrizeIds or {}
		self._txtAmout.text = langPara("%s", self._actInfo.activeCount)

		self._playerSliderMo:updatePlayerReward()
	end
end

function YearCardSpaceProgress2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardSpaceProgress2023View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardSpaceProgress2023View:_initPlayerParams()
	if not self._prizeCfg then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._prizeCfg

	function playerParam.getPlayerProgress()
		return YearCardModel.instance:getCurActiveCount(self._curActId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.progress <= self._curAmout and not self._hasGainPrizeIds[rewardCfg.prizeId] and self._curActive
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return self._hasGainPrizeIds[rewardCfg.prizeId]
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		YearCardController.instance:gainSpaceProgressPrize(self._curActId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function YearCardSpaceProgress2023View:_onResloadFinish(res)
	local resPath = self._url

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._res = res

		self._res:Retain()

		local prefab = self._res:GetMainAsset()

		if prefab then
			self._bigImg = goutil.clone(prefab)

			goutil.clearChildren(self._con)
			goutil.addChildToParent(self._bigImg, self._con)
			GameUtil.setAnchoredPos(self._bigImg, 0, 0)
			GameUtil.setLocalScale(self._bigImg, 1, 1, 1)
		end
	end
end

return YearCardSpaceProgress2023View
