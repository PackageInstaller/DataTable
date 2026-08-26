-- chunkname: @modules/logic/survival/view/tech/SurvivalTechView.lua

module("modules.logic.survival.view.tech.SurvivalTechView", package.seeall)

local SurvivalTechView = class("SurvivalTechView", BaseView)

function SurvivalTechView:onInitView()
	self.tabs = gohelper.findChild(self.viewGO, "root/Left/tabs")
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnReset")
	self.textTechPoint = gohelper.findChildTextMesh(self.viewGO, "root/currency/tag/#txt_tag")
	self.SurvivalTechTab = gohelper.findChild(self.tabs, "SurvivalTechTab")
	self.go_fragments = gohelper.findChild(self.viewGO, "root/go_fragments")
	self.animFragment = self.go_fragments:GetComponent(gohelper.Type_Animator)
	self.SurvivalTechCommonFragment = gohelper.findChild(self.go_fragments, "SurvivalTechCommonFragment")
	self.SurvivalTechRoleFragment = gohelper.findChild(self.go_fragments, "SurvivalTechRoleFragment")
	self.techDesc = gohelper.findChild(self.viewGO, "root/techDesc")
	self.animTechDesc = SLFramework.AnimatorPlayer.Get(self.techDesc)
	self.btn_closeDetail1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_fragments/SurvivalTechCommonFragment/ScrollView/btn_closeDetail1")
	self.btn_closeDetail2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_fragments/SurvivalTechRoleFragment/btn_closeDetail2")
	self.textDesc = gohelper.findChildTextMesh(self.techDesc, "textDesc")
	self.textName = gohelper.findChildTextMesh(self.techDesc, "textName")
	self.textPoint = gohelper.findChildTextMesh(self.techDesc, "textTechPoint")
	self.btnUp = gohelper.findChildButtonWithAudio(self.techDesc, "btnUp")
	self.btnLack = gohelper.findChildButtonWithAudio(self.techDesc, "btnLack")
	self.imgItemIcon = gohelper.findChildImage(self.textTechPoint.gameObject, "icon")
	self.imgItemIcon2 = gohelper.findChildImage(self.textPoint.gameObject, "icon")
	self.roleTechIconNode = gohelper.findChild(self.techDesc, "Item/roleTechIconNode")
	self.image_talenicon = gohelper.findChildImage(self.roleTechIconNode, "#image_talenicon")
	self.image_talenicon2 = gohelper.findChildSingleImage(self.techDesc, "Item/#image_talenicon2")
	self.State_Sp = gohelper.findChild(self.roleTechIconNode, "State_Sp")
	self.survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo

	gohelper.setActive(self.techDesc, false)

	local param = SimpleListParam.New()

	param.cellClass = SurvivalTechTab
	self.tabList = GameFacade.createSimpleListComp(self.tabs, param, self.SurvivalTechTab, self.viewContainer)

	self.tabList:setOnClickItem(self.onClickTab, self)
	self.tabList:setOnSelectChange(self.onSelectChange, self)

	self.survivalTechCommonFragment = MonoHelper.addNoUpdateLuaComOnceToGo(self.SurvivalTechCommonFragment, SurvivalTechCommonFragment, self)
	self.survivalTechRoleFragment = MonoHelper.addNoUpdateLuaComOnceToGo(self.SurvivalTechRoleFragment, SurvivalTechRoleFragment, self)
end

function SurvivalTechView:addEvents()
	self.addClickCb(self, self.btnReset, self.onClickBtnReset, self)
	self.addClickCb(self, self.btnUp, self.onClickBtnUp, self)
	self.addClickCb(self, self.btnLack, self.onClickBtnLack, self)
	self.addClickCb(self, self.btn_closeDetail1, self.onClickBtn_closeDetail, self)
	self.addClickCb(self, self.btn_closeDetail2, self.onClickBtn_closeDetail, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTechChange, self.onTechChange, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalOutSideTechUnlockReply, self.onTechChange, self)
end

function SurvivalTechView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	self.survivalTechCommonFragment:setData(0)

	local data = {}
	local list = SurvivalTechConfig.instance:getTechTabList()

	for i, info in ipairs(list) do
		table.insert(data, {
			techId = info.belongRole
		})
	end

	self.tabList:setData(data)
	self.tabList:setSelect(1)
	self:selectCell(nil)
end

function SurvivalTechView:onClose()
	return
end

function SurvivalTechView:onDestroyView()
	self.image_talenicon2:UnLoadImage()
	TaskDispatcher.cancelTask(self.onSelectChangeAnim, self)
end

function SurvivalTechView:onClickBtnReset()
	local item = self.tabList:getCurSelectItem()
	local techId = item.techId

	if self.survivalOutSideTechMo:haveFinish(techId) then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalTeachResetTip, MsgBoxEnum.BoxType.Yes_No, function()
			SurvivalOutSideRpc.instance:sendSurvivalOutSideTechResetRequest(techId)
		end)
	else
		GameFacade.showToastString(luaLang("SurvivalTechView_2"))
	end
end

function SurvivalTechView:onClickTab(simpleListItem)
	self.tabList:setSelect(simpleListItem.itemIndex)
end

function SurvivalTechView:onSelectChange(item, select)
	self.animFragment:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.onSelectChangeAnim, self)
	TaskDispatcher.runDelay(self.onSelectChangeAnim, self, 0.167)
end

function SurvivalTechView:onSelectChangeAnim(techId)
	local select = self.tabList:getSelect()
	local item = self.tabList:getCurSelectItem()

	if select == nil then
		-- block empty
	elseif select == 1 then
		gohelper.setActive(self.survivalTechCommonFragment.viewGO, true)
		gohelper.setActive(self.survivalTechRoleFragment.viewGO, false)
	else
		gohelper.setActive(self.survivalTechCommonFragment.viewGO, false)
		gohelper.setActive(self.survivalTechRoleFragment.viewGO, true)

		local item = self.tabList:getCurSelectItem()

		self.survivalTechRoleFragment:setData(item.techId)
	end

	self:selectCell(nil)
	self:refreshTechPoint()

	local iconId = 0

	if item.techId ~= 0 then
		local roleCfg = SurvivalRoleConfig.instance:getRoleCfgByTechId(item.techId)

		iconId = roleCfg.techSpriteId
	end

	local icon = "survival_talenticon_" .. iconId

	UISpriteSetMgr.instance:setSurvivalSprite2(self.imgItemIcon, icon)
	UISpriteSetMgr.instance:setSurvivalSprite2(self.imgItemIcon2, icon)
end

function SurvivalTechView:selectCell(itemIndex, id)
	if self.tabList:getSelect() == 1 then
		self.survivalTechCommonFragment:selectCell(itemIndex, id)
		self:setTechInfoNode(itemIndex ~= nil, id)
	else
		local isFinish = self.survivalTechRoleFragment:selectCell(itemIndex, id)

		if isFinish then
			self:setTechInfoNode(false, id)
		else
			self:setTechInfoNode(itemIndex ~= nil, id)
		end
	end
end

function SurvivalTechView:onReceiveSurvivalOutSideTechUnlockReply()
	self:setTechInfoNode(false)
end

function SurvivalTechView:setTechInfoNode(isShow, teachCellId)
	if isShow then
		AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_draw)

		if not self.isShowTechDesc then
			gohelper.setActive(self.techDesc, true)
			self.animTechDesc:Play("open", nil, nil)
		end

		self.infoNodeTeachCellId = teachCellId
		self.infoNodeTeachCellCfg = lua_survival_outside_tech.configDict[teachCellId]
		self.isShowTechDesc = isShow

		self:refreshDescBtn()
	else
		if self.isShowTechDesc then
			self.animTechDesc:Play("close", nil, nil)
		end

		self.isShowTechDesc = isShow
	end
end

function SurvivalTechView:onClickBtnUp()
	local techId = self:getTechId()
	local isCanUp = self.survivalOutSideTechMo:isCanUp(techId, self.infoNodeTeachCellId)

	if isCanUp then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideTechUnlockRequest(techId, self.infoNodeTeachCellId)
	end
end

function SurvivalTechView:onClickBtnLack()
	local techId = self:getTechId()
	local isPreNodeSatisfy = self.survivalOutSideTechMo:isPreNodeSatisfy(self.infoNodeTeachCellId)
	local isTechPointSatisfy = self.survivalOutSideTechMo:isTechPointSatisfy(techId, self.infoNodeTeachCellId)

	if not isTechPointSatisfy then
		GameFacade.showToastString(luaLang("SurvivalTechView_4"))
	elseif not isPreNodeSatisfy then
		GameFacade.showToastString(luaLang("SurvivalTechView_5"))
	end
end

function SurvivalTechView:onClickBtn_closeDetail()
	self:selectCell(nil)
end

function SurvivalTechView:onTechChange()
	self:refreshTechPoint()
	self:refreshDescBtn()
end

function SurvivalTechView:refreshTechPoint()
	local techId = self:getTechId()

	self.textTechPoint.text = self.survivalOutSideTechMo:getTechPoint(techId)
end

function SurvivalTechView:getTechId()
	local item = self.tabList:getCurSelectItem()

	return item.techId
end

function SurvivalTechView:refreshDescBtn()
	if self.isShowTechDesc then
		local techId = self:getTechId()
		local isFinish = self.survivalOutSideTechMo:isFinish(techId, self.infoNodeTeachCellId)
		local isPreNodeSatisfy = self.survivalOutSideTechMo:isPreNodeSatisfy(self.infoNodeTeachCellId)
		local isTechPointSatisfy = self.survivalOutSideTechMo:isTechPointSatisfy(techId, self.infoNodeTeachCellId)
		local isCanUp = not isFinish and isPreNodeSatisfy and isTechPointSatisfy

		gohelper.setActive(self.btnLack, not isFinish and (not isTechPointSatisfy or not isPreNodeSatisfy))
		gohelper.setActive(self.btnUp, isCanUp)
		gohelper.setActive(self.State_Sp, self.infoNodeTeachCellCfg.sign == 1)

		self.textName.text = self.infoNodeTeachCellCfg.name
		self.textDesc.text = self.infoNodeTeachCellCfg.desc

		if isFinish then
			gohelper.setActive(self.textPoint.gameObject, false)
		else
			gohelper.setActive(self.textPoint.gameObject, true)

			self.textPoint.text = not self.survivalOutSideTechMo:isTechPointSatisfy(self:getTechId(), self.infoNodeTeachCellId) and string.format("<color=#DD4F44>%s</color>", self.infoNodeTeachCellCfg.cost) or string.format("<color=#FFFFFF>%s</color>", self.infoNodeTeachCellCfg.cost)
		end

		if techId == 0 then
			gohelper.setActive(self.roleTechIconNode, true)
			gohelper.setActive(self.image_talenicon2, false)

			local cfg = lua_survival_outside_tech.configDict[self.infoNodeTeachCellId]

			if not string.nilorempty(cfg.icon) then
				UISpriteSetMgr.instance:setSurvivalSprite2(self.image_talenicon, cfg.icon)
			end
		else
			gohelper.setActive(self.roleTechIconNode, false)
			gohelper.setActive(self.image_talenicon2, true)

			local item = self.survivalTechRoleFragment:getCurSlotList():getCurSelectItem()

			self.image_talenicon2:LoadImage(item.icon)
		end
	end
end

return SurvivalTechView
