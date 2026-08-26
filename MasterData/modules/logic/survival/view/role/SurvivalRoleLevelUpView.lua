-- chunkname: @modules/logic/survival/view/role/SurvivalRoleLevelUpView.lua

module("modules.logic.survival.view.role.SurvivalRoleLevelUpView", package.seeall)

local SurvivalRoleLevelUpView = class("SurvivalRoleLevelUpView", BaseView)

function SurvivalRoleLevelUpView:onInitView()
	self.animator = self.viewGO:GetComponent("Animator")
	self.attrNode = gohelper.findChild(self.viewGO, "root/attrNode")
	self.attrItems = gohelper.findChild(self.attrNode, "items")
	self.tip1 = gohelper.findChild(self.attrNode, "ver/#go_tips")
	self.tip2 = gohelper.findChild(self.attrNode, "ver/#go_tips2")
	self.desc = gohelper.findChild(self.attrNode, "desc")
	self.textDesc = gohelper.findChildTextMesh(self.desc, "layout/textDesc")
	self.survivalrolelevelcomp = gohelper.findChild(self.viewGO, "root/survivalrolelevelcomp")
	self.txt_close = gohelper.findChild(self.viewGO, "root/txt_close")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self.survivalRoleLevelComp = GameFacade.createLuaCompByGo(self.survivalrolelevelcomp, SurvivalRoleLevelComp)

	local param = SimpleListParam.New()

	param.cellClass = SurvivalRoleLevelUpAttrItem
	self.attrList = GameFacade.createSimpleListComp(self.attrItems, param, nil, self.viewContainer)

	for i = 1, 5 do
		local go = gohelper.findChild(self.attrItems, "SurvivalRoleLevelUpAttrItem" .. i)

		self.attrList:addCustomItem(go)
	end

	self.attrList:setOnClickItem(self.onClickAttr, self)

	self.survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	self.flow = FlowSequence.New()

	self:setAttrDescShow(false)
end

function SurvivalRoleLevelUpView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
end

function SurvivalRoleLevelUpView:onClickBtnClose()
	if self.isShowDesc then
		self:setAttrDescShow(false)
	else
		self:closeThis()
	end
end

function SurvivalRoleLevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_1)

	if self.viewParam then
		self.oldLevel = self.viewParam.oldLevel or self.survivalShelterRoleMo.level - 1
	end

	if self.viewParam then
		self.curLevel = self.viewParam.curLevel or self.survivalShelterRoleMo.level
	end

	gohelper.setActive(self.txt_close.gameObject, true)
	gohelper.setActive(self.btnClose.gameObject, true)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local data = {}
	local ids = SurvivalRoleConfig.instance:getRoleAttrIds()
	local oldRoleAttrDic = weekInfo.oldRoleAttrDic
	local curRoleAttrDic = weekInfo.curRoleAttrDic

	for i, attrId in ipairs(ids) do
		local isIncrease = true
		local value
		local old = oldRoleAttrDic[attrId]
		local new = curRoleAttrDic[attrId]

		value = isIncrease and old or self.survivalShelterRoleMo:getRoleAttrValue(attrId)

		table.insert(data, {
			value = old,
			isIncrease = isIncrease,
			old = old,
			new = new
		})
	end

	self.attrList:setData(data)
	gohelper.setActive(self.survivalRoleLevelComp.viewGO, true)

	local isRepress = false
	local fight = weekInfo:getMonsterFight()
	local intrudeSchemeMos = fight.intrudeSchemeMos

	if intrudeSchemeMos then
		for i, mo in ipairs(intrudeSchemeMos) do
			if mo.point > self.oldLevel and mo.point <= self.curLevel then
				isRepress = true

				break
			end
		end
	end

	gohelper.setActive(self.attrNode, false)
	gohelper.setActive(self.tip1, SurvivalTechConfig.instance:haveUnlockTech(self.oldLevel, self.curLevel))
	gohelper.setActive(self.tip2, isRepress)
	self.flow:addWork(FunctionWork.New(function()
		gohelper.setActive(self.txt_close.gameObject, false)
		gohelper.setActive(self.btnClose.gameObject, false)
	end))

	local work = self.survivalRoleLevelComp:getLevelUpAnimWork(self.oldLevel, self.curLevel, nil, nil, true)

	self.flow:addWork(work)
	self.flow:addWork(TimerWork.New(0.5))
	self.flow:addWork(FunctionWork.New(function()
		gohelper.setActive(self.survivalRoleLevelComp.viewGO, false)
		gohelper.setActive(self.attrNode, true)
		self.animator:Play("switch")
		AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_success)
	end))
	self.flow:addWork(TimerWork.New(0.8))

	local numAnims = {}
	local items = self.attrList:getItems()

	for i, v in ipairs(items) do
		local animWork = v:getNumAnimWork()

		if animWork then
			table.insert(numAnims, animWork)
		end
	end

	if #numAnims > 0 then
		local flowParallel = FlowParallel.New()

		for i, v in ipairs(numAnims) do
			flowParallel:addWork(v)
		end

		self.flow:addWork(flowParallel)
	end

	self.flow:addWork(FunctionWork.New(function()
		gohelper.setActive(self.txt_close.gameObject, true)
		gohelper.setActive(self.btnClose.gameObject, true)
	end))
	self.flow:start()
end

function SurvivalRoleLevelUpView:onClose()
	return
end

function SurvivalRoleLevelUpView:onDestroyView()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

function SurvivalRoleLevelUpView:onClickAttr(item)
	self:setAttrDescShow(true, item.itemIndex)
end

function SurvivalRoleLevelUpView:setAttrDescShow(isShow, id)
	gohelper.setActive(self.desc, isShow)

	self.isShowDesc = isShow

	if isShow then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		self.textDesc.text = weekInfo:getRoleAttrTips(id)
	end
end

return SurvivalRoleLevelUpView
