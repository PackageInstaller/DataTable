-- chunkname: @modules/logic/fight/view/FightSupportEventView.lua

module("modules.logic.fight.view.FightSupportEventView", package.seeall)

local FightSupportEventView = class("FightSupportEventView", FightBaseView)

function FightSupportEventView:onInitView()
	self.titleNameText = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self.itemContent = gohelper.findChild(self.viewGO, "LayoutGroup")
	self.itemObj = gohelper.findChild(self.viewGO, "LayoutGroup/#go_Item")
end

function FightSupportEventView:addEvents()
	return
end

function FightSupportEventView:removeEvents()
	return
end

function FightSupportEventView:onOpen()
	self.buffData = self.viewParam.buffData

	local buffConfig = lua_skill_buff.configDict[self.buffData.buffId]

	if buffConfig then
		self.titleNameText.text = buffConfig.name
	end

	self.idList = self.viewParam.actInfo.param

	table.remove(self.idList, #self.idList)

	self.objList = {}

	self:com_createObjList(self.onItemShow, self.idList, self.itemContent, self.itemObj)

	if FightDataHelper.stateMgr:getIsAuto() then
		self:com_registTimer(self.autoSelect, 5)
	end
end

function FightSupportEventView:onItemShow(obj, id, index)
	local config = lua_battle_selection.configDict[id]

	if not config then
		gohelper.setActive(obj, false)

		return
	end

	table.insert(self.objList, obj)

	local titleText = gohelper.findChildText(obj, "image_Card/#txt_Title")

	titleText.text = config.title

	local contentText = gohelper.findChildText(obj, "image_Card/Scroll View/Viewport/Content")

	contentText.text = config.desc

	local confirmText = gohelper.findChildText(obj, "#btn_Fight/txt_Fight")

	confirmText.text = config.confirm

	local url = ResUrl.getHeadIconSmall(config.icon)
	local cardIcon = gohelper.findChildSingleImage(obj, "image_Card/heroitem/role/heroicon")

	cardIcon:LoadImage(url)
	gohelper.setActive(gohelper.findChild(obj, "image_Card/heroitem/role/rare"), false)
	gohelper.setActive(gohelper.findChild(obj, "image_Card/heroitem/role/career"), false)
	gohelper.setActive(gohelper.findChild(obj, "image_Card/heroitem/role/mask"), false)
	gohelper.setActive(gohelper.findChild(obj, "image_Card/heroitem/role/name"), false)

	local confirmBtn = gohelper.findChildClick(obj, "#btn_Fight")

	self:com_registClick(confirmBtn, self.onClickConfirm, {
		config = config,
		obj = obj
	})
end

function FightSupportEventView:onClickConfirm(param)
	local config = param.config
	local obj = param.obj
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkPlayAnimator, obj, "close")
	flow:registWork(FightWorkPlayAnimator, self.viewGO, "close")
	flow:registWork(FightWorkFunction, FightRpc.instance.sendUseClothSkillRequest, FightRpc.instance, config.id, "0", "0", FightEnum.ClothSkillType.BattleSelection)
	flow:registFinishCallback(self.onFlowFinish, self)
	flow:start()
end

function FightSupportEventView:onFlowFinish()
	self:closeThis()
end

function FightSupportEventView:autoSelect()
	local config = lua_battle_selection.configDict[self.idList[1]]
	local param = {
		config = config,
		obj = self.objList[1]
	}

	self:onClickConfirm(param)
end

function FightSupportEventView:onClose()
	return
end

function FightSupportEventView:onDestroyView()
	return
end

return FightSupportEventView
