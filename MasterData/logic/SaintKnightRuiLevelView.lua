-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiLevelView.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiLevelView", package.seeall)

local SaintKnightRuiLevelView = class("SaintKnightRuiLevelView", ViewComponent)

function SaintKnightRuiLevelView:ctor()
	SaintKnightRuiLevelView.super.ctor(self)
end

function SaintKnightRuiLevelView:buildUI()
	SaintKnightRuiLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("right/tablecell")
	self._tableviewGo = self:getGo("right/tableview")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regReloadFinish(GameUtil.handler(self.reloadFinish, self))

	self._txtName = self:getTxt("txtName")
	self._imgBg = self:getGo("imgBg")
	self._imgTitle = self:getGo("imgBg/imgTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("imgBg/imgTitle/txtTitle")
	self._colorChange = self._txtTitle.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._role = self:getGo("imgBg/role")
	self._petPhotoShow = PetPhotoShow.Get(self._role)
end

function SaintKnightRuiLevelView:bindEvents()
	SaintKnightRuiLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SaintKnightRuiLevelView:unbindEvents()
	SaintKnightRuiLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SaintKnightRuiLevelView:onEnter()
	SaintKnightRuiLevelView.super.onEnter(self)

	self._stageId = self:getFirstParam()
	self._activityId = SaintKnightRuiModel.instance:getActivityId()
	self._challengePlanId = SaintKnightRuiModel.instance:getChallengePlanId()
	self._cfgActivity = SaintKnightRuiConfig.instance:getActivityCfg(self._activityId)
	self._selectIndex = 1

	self:_updateView()
end

function SaintKnightRuiLevelView:onExit()
	SaintKnightRuiLevelView.super.onExit(self)
	self._tableview:dispose()
	self:_clearRT()
end

function SaintKnightRuiLevelView:_onClickClose()
	self:close()
end

function SaintKnightRuiLevelView:reloadFinish()
	if self._selectIndex then
		self._tableview:MoveCellToCenter(self._selectIndex - 1)
	end
end

function SaintKnightRuiLevelView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local item2 = goutil.findChild(cell, "item2")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local select = goutil.findChild(cell, "select")
	local fight = goutil.findChild(cell, "fight")
	local pass = goutil.findChild(cell, "pass")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local bg = goutil.findChild(cell, "bg")
	local cfgCreeps = SaintKnightRuiConfig.instance:getFmtById(data.creepsMasterId)

	btn:AddClickListener(function()
		if data.isPass then
			FloatWordMgr.instance:show("已通关")
		elseif data.isSelect then
			local customFmtMo = SaintKnightRuiModel.instance:getCustomFmtMo()

			customFmtMo:initParams(self._activityId, self._stageId, cfgCreeps)
			CustomFmtController.instance:showMissionView(customFmtMo)
		else
			FloatWordMgr.instance:show("请先通过上一关卡")
		end
	end)

	txtName.text = cfgCreeps.name

	goutil.setActive(select, data.isSelect)
	goutil.setActive(fight, data.isSelect)
	goutil.setActive(pass, data.isPass)

	local rewardList = MaterialMgr.changeItemStrArr(cfgCreeps.reward)

	if rewardList[1] then
		MaterialMgr.setCellByCfg(rewardList[1], item)
	end

	if rewardList[2] then
		MaterialMgr.setCellByCfg(rewardList[2], item2)
	end

	local cfgInfo = SaintKnightRuiConfig.instance:getStateInfoCfg(data.challengePlanId, data.stageId)

	if cfgInfo then
		uGuiUtil.setSpriteToImage(bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("saintknight/xiaorui", cfgInfo.spriteName3))
	end
end

function SaintKnightRuiLevelView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local item2 = goutil.findChild(cell, "item2")
	local bg = goutil.findChild(cell, "bg")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
	MaterialMgr.resetAll(item)
	MaterialMgr.resetAll(item2)
	uGuiUtil.clearImage(bg)
end

function SaintKnightRuiLevelView:_updateView()
	self:_updateDetail()
	self:_updateList()
end

function SaintKnightRuiLevelView:_updateDetail()
	local cfg = SaintKnightRuiConfig.instance:getStateInfoCfg(self._challengePlanId, self._stageId)

	if cfg then
		self._txtName.text = cfg.name
	end
end

function SaintKnightRuiLevelView:_updateList()
	local cfgs = SaintKnightRuiConfig.instance:getSortStageCfgs(self._challengePlanId, self._stageId)
	local passCreepsMasterId = SaintKnightRuiModel.instance:getPassCreepsMasterId(self._stageId)
	local list = {}
	local isHit = false

	for i, v in ipairs(cfgs) do
		local data = {}

		data.challengePlanId = v.challengePlanId
		data.stageId = v.stageId
		data.creepsMasterId = v.creepsMasterId
		data.desc = v.desc
		data.raceId = v.raceId
		data.isPass = passCreepsMasterId >= v.creepsMasterId

		if not data.isPass and not isHit then
			isHit = true
			data.isSelect = true

			self:_updateSelect(data)

			self._selectIndex = i
		else
			data.isSelect = false
		end

		table.insert(list, data)
	end

	if not isHit then
		local lastCfg = cfgs[#cfgs]
		local data = {}

		data.challengePlanId = lastCfg.challengePlanId
		data.stageId = lastCfg.stageId
		data.desc = lastCfg.desc
		data.raceId = lastCfg.raceId

		self:_updateSelect(data)
	end

	self._tableview:reloadData(list)
end

function SaintKnightRuiLevelView:_updateSelect(data)
	local cfgInfo = SaintKnightRuiConfig.instance:getStateInfoCfg(data.challengePlanId, data.stageId)

	if cfgInfo then
		self:_updateImg(cfgInfo)
		self:_updateText(cfgInfo, data.desc)
		self:_loadRoleRT(data.raceId)
	end
end

function SaintKnightRuiLevelView:_updateImg(cfgInfo)
	uGuiUtil.setSpriteToImage(self._imgBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("saintknight/xiaorui", cfgInfo.spriteName1))
	uGuiUtil.setSpriteToImage(self._imgTitle, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("saintknight/xiaorui", cfgInfo.spriteName2))
end

function SaintKnightRuiLevelView:_clearImg()
	uGuiUtil.clearImage(self._imgBg)
	uGuiUtil.clearImage(self._imgTitle)
end

function SaintKnightRuiLevelView:_updateText(cfgInfo, desc)
	self._txtTitle.text = cfgInfo.name
	self._txtDesc.text = desc

	printInfo("test _updateText", cfgInfo.stageId, cfgInfo.stageId - 1)
	self._colorChange:SetState(cfgInfo.stageId - 1)
end

function SaintKnightRuiLevelView:_loadRoleRT(skinId)
	printInfo("test _loadRoleRT", skinId)
	self._petPhotoShow:showPetEffect(skinId, false, 4)
	self._petPhotoShow:setPetLocalPosAndScale(1.5, 0, 0.5)
end

function SaintKnightRuiLevelView:_clearRT()
	self._petPhotoShow:clear()
end

return SaintKnightRuiLevelView
