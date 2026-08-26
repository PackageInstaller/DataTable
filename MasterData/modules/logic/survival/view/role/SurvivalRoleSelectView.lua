-- chunkname: @modules/logic/survival/view/role/SurvivalRoleSelectView.lua

module("modules.logic.survival.view.role.SurvivalRoleSelectView", package.seeall)

local SurvivalRoleSelectView = class("SurvivalRoleSelectView", BaseView)

function SurvivalRoleSelectView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self.role = gohelper.findChild(self.root, "role")
	self.SurvivalRoleSelectItem = gohelper.findChild(self.role, "SurvivalRoleSelectItem")
	self.select = gohelper.findChild(self.root, "select")
	self.textName = gohelper.findChildTextMesh(self.select, "#txt_name")
	self.textTalent = gohelper.findChildTextMesh(self.select, "#scroll_info/Viewport/Content/#go_talent/#txt_talentdesc")
	self.txt_talentname = gohelper.findChildTextMesh(self.select, "#scroll_info/Viewport/Content/#go_talent/talentnamebg/#txt_talentname")
	self.btn_Lock = gohelper.findChild(self.select, "#btn_Lock")
	self.go_lock = gohelper.findChild(self.select, "#go_lock")
	self.textLock = gohelper.findChildTextMesh(self.go_lock.gameObject, "#txt_lock")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.select, "#btn_Confirm")
	self.img_picture = gohelper.findChildSingleImage(self.select, "#img_picture")
	self.skillContent = gohelper.findChild(self.select, "#scroll_info/Viewport/Content")
	self.bottomTip = gohelper.findChild(self.viewGO, "root/BG/Left/txt_tips")
	self.SurvivalRoleSelectSkillItem = gohelper.findChild(self.skillContent, "#go_skill")
	self.selectAnimator = self.select:GetComponent(typeof(UnityEngine.Animator))

	local param = SimpleListParam.New()

	param.cellClass = SurvivalRoleSelectItem
	self.roleList = GameFacade.createSimpleListComp(self.role, param, self.SurvivalRoleSelectItem, self.viewContainer)

	self.roleList:setOnClickItem(self.onClickRoleItem, self)
	self.roleList:setOnSelectChange(self.onSelectRoleChange, self)

	param = SimpleListParam.New()
	param.cellClass = SurvivalRoleSelectSkillItem
	self.skillList = GameFacade.createSimpleListComp(self.skillContent, param, self.SurvivalRoleSelectSkillItem, self.viewContainer)
	self.survivalroleattrcomp = gohelper.findChild(self.select, "survivalroleattrcomp")
	self.survivalRoleAttrComp = GameFacade.createLuaCompByGo(self.survivalroleattrcomp, SurvivalRoleAttrComp, nil, self.viewContainer)
	self.refreshFlow = FlowSequence.New()

	self.refreshFlow:addWork(TimerWork.New(0.167))
	self.refreshFlow:addWork(FunctionWork.New(self.refreshSelect, self))
end

function SurvivalRoleSelectView:addEvents()
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
end

function SurvivalRoleSelectView:onOpen()
	self.survivalOutSideRoleModel = SurvivalModel.instance:getOutSideInfo().survivalOutSideRoleMo
	self.difficultyId = self.viewParam.difficultyId

	local str = lua_survival_hardness_mod.configDict[self.difficultyId].initRole
	local roleIds = string.splitToNumber(str, "#")
	local data = {}

	for i, id in ipairs(roleIds) do
		local cfg = lua_survival_role.configDict[id]

		table.insert(data, {
			cfg = cfg,
			context = self
		})
	end

	self.roleList:setData(data)

	local select = 1
	local roleId = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SurvivalRoleSelect, -1)

	if roleId ~= -1 and SurvivalRoleConfig.instance:haveRole(roleId) then
		for i, v in ipairs(data) do
			if v.cfg.id == roleId then
				select = i

				break
			end
		end
	end

	self.roleList:setSelect(select)

	local isStory = SurvivalDifficultyModel.instance:isStoryDifficulty()

	gohelper.setActive(self.bottomTip, isStory)
	self.survivalOutSideRoleModel:markNew()
end

function SurvivalRoleSelectView:onClose()
	return
end

function SurvivalRoleSelectView:onDestroyView()
	self.img_picture:UnLoadImage()
end

function SurvivalRoleSelectView:onClickBtnConfirm()
	local item = self.roleList:getCurSelectItem()
	local roleId = item.cfg.id

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalRoleSelect, -1)
	SurvivalDifficultyModel.instance:sendDifficultyChoose(roleId)
end

function SurvivalRoleSelectView:onClickRoleItem(survivalRoleSelectItem)
	if survivalRoleSelectItem.isUnLockFuture then
		GameFacade.showToastString(luaLang("SurvivalRoleSelectView_2"))

		return
	end

	self.roleList:setSelect(survivalRoleSelectItem.itemIndex)
end

function SurvivalRoleSelectView:onSelectRoleChange(item, select, oldSelect)
	if oldSelect == nil then
		self:refreshSelect()

		return
	end

	self.selectAnimator:Play("switch", 0, 0)
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalRoleSelectView:refreshSelect()
	local item = self.roleList:getCurSelectItem()
	local cfg = item.cfg

	self.cfg = cfg
	self.textName.text = cfg.name

	local cardPath = SurvivalRoleConfig.instance:getRoleCardImage(cfg.id)

	if not string.nilorempty(cardPath) then
		self.img_picture:LoadImage(ResUrl.getSurvivalTeamIcon(cardPath))
	end

	self.txt_talentname.text = cfg.talentName
	self.textTalent.text = cfg.desc

	self.survivalRoleAttrComp:setData(1, cfg.id)

	local isLock = self.survivalOutSideRoleModel:isRoleLock(cfg.id)

	gohelper.setActive(self.go_lock, isLock)
	gohelper.setActive(self.btn_Lock, isLock)
	gohelper.setActive(self.btnConfirm, not isLock)

	if isLock then
		self.textLock.text = self.survivalOutSideRoleModel:getUnlockDesc(cfg.id)
	end

	local skillData = {
		{
			heroId = self.cfg.id,
			skillId = self.cfg.skill
		}
	}

	self.skillList:setData(skillData)
end

return SurvivalRoleSelectView
