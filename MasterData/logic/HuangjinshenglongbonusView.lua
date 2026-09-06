-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/HuangjinshenglongbonusView.lua

module("logic.extensions.bonus.view.christmasandnewyear.HuangjinshenglongbonusView", package.seeall)

local HuangjinshenglongbonusView = class("HuangjinshenglongbonusView", SummarySubTabView)

function HuangjinshenglongbonusView:ctor()
	HuangjinshenglongbonusView.super.ctor(self)
end

function HuangjinshenglongbonusView:init()
	HuangjinshenglongbonusView.super.init(self)

	self.petIdCfg = checknumber(self._cfgs[1].background)
end

function HuangjinshenglongbonusView:unbindEvents()
	GameUtil.rmClickHandler(self.btnInfo)
	GameUtil.rmClickHandler(self.btnSkill)
	self._bubbleBtn:RemoveClickListener()
	HuangjinshenglongbonusView.super.unbindEvents(self)
end

function HuangjinshenglongbonusView:bindEvents()
	HuangjinshenglongbonusView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnInfo, self.onClickInfo, self)
	GameUtil.addClickHandler(self.btnSkill, self.onClickSkill, self)
	self._bubbleBtn:AddClickListener(self._showBubble, self)
end

function HuangjinshenglongbonusView:buildUI()
	HuangjinshenglongbonusView.super.buildUI(self)

	self._con = self:getGo("petCon")
	self.rare = self:getGo("petInfo/rare")
	self.btnInfo = self:getGo("petInfo/btnInfo")
	self.btnSkill = self:getGo("petInfo/btnSkill")
	self._bubble = self:getGo("bubble")
	self._bubbleBtn = self:getBtn("bubbleBtn")
end

function HuangjinshenglongbonusView:onExit()
	self.role = RoleObjectPool.instance:removeRole(self.role)

	MaterialMgr.resetAll(self.rare)
	removetimer(self._initBubble, self)

	if self.textTween then
		self.textTween:Kill(true)
	end

	HuangjinshenglongbonusView.super.onExit(self)
end

function HuangjinshenglongbonusView:onEnter()
	HuangjinshenglongbonusView.super.onEnter(self)

	self._bubbleMark = "ShowTalkMark" .. self.petIdCfg

	self:updateUI()
	self._bubble:SetActive(false)
	settimer(0.2, self._initBubble, self, false)
end

function HuangjinshenglongbonusView:updateUI()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self.petIdCfg)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self.role = RoleObjectPool.instance:addRoleToParent(self.role, self.petIdCfg, self._con, scale, nil, true, modelCfg[1], y)

				MaterialMgr.setCell(MatType.Rare, self.petIdCfg, self.rare)
			end
		end
	end
end

function HuangjinshenglongbonusView:onClickInfo()
	PetbookController.instance:openPetinfoView(self.petIdCfg)
end

function HuangjinshenglongbonusView:onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.petIdCfg)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.petIdCfg)
	end
end

function HuangjinshenglongbonusView:_showBubble()
	if self.textTween then
		self.textTween:Kill(true)
	end
end

function HuangjinshenglongbonusView:_initBubble()
	local tip = lang("text_hjsl_desc")
	local textShow = self:getTxt("bubble/txtDesc")

	self._bubble:SetActive(true)

	if GameUtil.getUserData(self._bubbleMark) then
		textShow.text = tip
	else
		textShow.text = ""
		self.textTween = textShow:DOText(tip, 10, false)

		GameUtil.saveUserData(self._bubbleMark, "1")
	end
end

return HuangjinshenglongbonusView
