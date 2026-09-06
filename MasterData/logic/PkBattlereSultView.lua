-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkBattlereSultView.lua

module("logic.extensions.pk.view.PkBattlereSultView", package.seeall)

local PkBattlereSultView = class("PkBattlereSultView", ViewComponent)

function PkBattlereSultView:ctor()
	PkBattlereSultView.super.ctor(self)
end

function PkBattlereSultView:buildUI()
	PkBattlereSultView.super.buildUI(self)
	self:_initTeams()

	self._imgBg = self:getBtn("imgBg")
	self._imgBase = self:getGo("imgBase")
	self._btnVideo = self:getBtn("Video")
	self._btnBattle = self:getBtn("btnBattle")
	self._btnShare = self:getBtn("btnShare")
	self._imgTitle = goutil.findChildComponent(self.mainGO, "imgTitle", "UIImageSpriteChange")
end

function PkBattlereSultView:bindEvents()
	PkBattlereSultView.super.bindEvents(self)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
	self._btnBattle:AddClickListener(self._onClickBattle, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
	self._imgBg:AddClickListener(self._onClickBg, self)
end

function PkBattlereSultView:unbindEvents()
	PkBattlereSultView.super.unbindEvents(self)
	self._btnVideo:RemoveClickListener()
	self._btnBattle:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	self._imgBg:RemoveClickListener()
end

function PkBattlereSultView:destroyUI()
	PkBattlereSultView.super.destroyUI(self)
end

function PkBattlereSultView:onEnter()
	PkBattlereSultView.super.onEnter(self)

	self._isVideo = self:getFirstParam()
	self._pkResult = TraincampqiecuoModel.instance:getPkResult()
	self._myForm = self._pkResult.myForm
	self._opForm = self._pkResult.opForm
	self._recordId = self._pkResult.recordId

	goutil.setActive(self._btnBattle.gameObject, false)
	goutil.setActive(self._btnShare.gameObject, self._recordId)

	self._attackVideo = TraincampqiecuoModel.instance:getPkAttackVideo()

	goutil.setActive(self._btnVideo.gameObject, self._attackVideo)

	if self._pkResult.state == 1 and self._pkResult.myPetLeftCount > self._pkResult.opPetLeftCount or self._pkResult.state == 3 then
		self._imgTitle:SetState(0)
	elseif self._pkResult.state == 1 and self._pkResult.myPetLeftCount < self._pkResult.opPetLeftCount or self._pkResult.state == 2 then
		self._imgTitle:SetState(1)
	else
		self._imgTitle:SetState(2)
	end

	if self._pkResult.state == 3 then
		TipsFacade.instance:openTipWindow(lang("tip"), "对方离开了切磋布阵")
	end

	self:_updateTeam()
end

function PkBattlereSultView:onEnterFinished()
	PkBattlereSultView.super.onEnterFinished(self)
end

function PkBattlereSultView:onExit()
	PkBattlereSultView.super.onExit(self)
	UIStateManager.instance:popByName(ViewName.PkmissionView)
	UIStateManager.instance:popByName(ViewName.PkFormationselectView)
	UIStateManager.instance:popByName(ViewName.PkFormationView)
	UIStateManager.instance:popByName(ViewName.PkFormationView)
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
	TraincampqiecuoModel.instance:setDefenseForm()
end

function PkBattlereSultView:onExitFinished()
	PkBattlereSultView.super.onExitFinished(self)
end

function PkBattlereSultView:_initTeams()
	self._teams = {}

	local leftTeams = {}
	local rightTeams = {}

	self._leftTitle = self:getTxt("Left/TitleName")
	self._rightTitle = self:getTxt("Right/TitleName")
	self._leftHead = self:getGo("Left/myInfo/head")
	self._leftName = self:getTxt("Left/myInfo/txtName")
	self._rightHead = self:getGo("Right/otherInfo/head")
	self._rightName = self:getTxt("Right/otherInfo/txtName")
	self._alivePetLeft = goutil.findChildComponent(self.mainGO, "Left/myInfo/aliveNum", "UIImgNumeralText")
	self._alivePetRight = goutil.findChildComponent(self.mainGO, "Right/otherInfo/aliveNum", "UIImgNumeralText")

	for i = 1, 9 do
		local go = self:getGo("Left/Item" .. i)

		leftTeams[i] = {}
		leftTeams[i].go = go
		leftTeams[i].icon = goutil.findChild(go, "Icon")
		leftTeams[i].isDead = goutil.findChild(go, "Dead")
	end

	for i = 1, 9 do
		local go = self:getGo("Right/Item" .. i)

		rightTeams[i] = {}
		rightTeams[i].go = go
		rightTeams[i].icon = goutil.findChild(go, "Icon")
		rightTeams[i].isDead = goutil.findChild(go, "Dead")
	end

	self._teams[GameEnum.BattleTeam.Left] = leftTeams
	self._teams[GameEnum.BattleTeam.Right] = rightTeams
end

function PkBattlereSultView:_updateTeam()
	local _teams = self._teams[GameEnum.BattleTeam.Left]

	for i, v in ipairs(self._myForm) do
		if v.raceId > 0 then
			_teams[i].go:SetActive(true)
			_teams[i].isDead:SetActive(v.isDead or false)

			local modelCo = CharacterConfig.instance:getModelCo(v.raceId)

			uGuiUtil.setSpriteToImage(_teams[i].icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		else
			_teams[i].go:SetActive(false)
		end
	end

	local headInfo = TraincampqiecuoModel.instance:getMyUserHeadInfo()

	self._leftName.text = headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(self._leftHead, headInfo)
	self._alivePetLeft:SetNum(self._pkResult.myPetLeftCount)

	_teams = self._teams[GameEnum.BattleTeam.Right]

	for i, v in ipairs(self._opForm) do
		if v.raceId > 0 then
			_teams[i].go:SetActive(true)
			_teams[i].isDead:SetActive(v.isDead or false)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(v.raceId))

			uGuiUtil.setSpriteToImage(_teams[i].icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		else
			_teams[i].go:SetActive(false)
		end
	end

	headInfo = TraincampqiecuoModel.instance:getOpUserHeadInfo()
	self._rightName.text = headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(self._rightHead, headInfo)
	self._alivePetRight:SetNum(self._pkResult.opPetLeftCount)
end

function PkBattlereSultView:_onClickBg()
	self:close()
end

function PkBattlereSultView:_onClickBattle()
	TraincampqiecuoController.instance:sendInvitation(TraincampqiecuoModel.instance:getOpUserHeadInfo())
	self:close()
end

function PkBattlereSultView:_onClickVideo()
	UIJumper.instance:pushOneStack(ViewName.PkmainView)

	if not self._isVideo then
		UIJumper.instance:pushOneStack(ViewName.PkroomView)
	end

	BattleFacade.instance:onViewUserFightMonsterBtlResult(self._attackVideo)
end

function PkBattlereSultView:_onClickShare()
	if self._pkResult.myPetLeftCount > self._pkResult.opPetLeftCount then
		self:_pushShareView(17)
	elseif self._pkResult.myPetLeftCount < self._pkResult.opPetLeftCount then
		self:_pushShareView(18)
	else
		self:_pushShareView(19)
	end
end

function PkBattlereSultView:_pushShareView(id)
	UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.SharePk, RoleModel.instance:getUserId(), self._recordId, id, self._rightName.text, string.format("%d:%d", self._pkResult.myPetLeftCount, self._pkResult.opPetLeftCount))
end

return PkBattlereSultView
