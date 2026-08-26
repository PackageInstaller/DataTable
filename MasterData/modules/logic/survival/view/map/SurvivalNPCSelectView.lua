-- chunkname: @modules/logic/survival/view/map/SurvivalNPCSelectView.lua

module("modules.logic.survival.view.map.SurvivalNPCSelectView", package.seeall)

local SurvivalNPCSelectView = class("SurvivalNPCSelectView", BaseView)
local isQuickSelect = false

function SurvivalNPCSelectView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._goempty = gohelper.findChild(self.viewGO, "root/go_empty")
	self._goscroll = gohelper.findChild(self.viewGO, "root/#scroll_List")
	self._gonpcitem = gohelper.findChild(self.viewGO, "root/#scroll_List/Viewport/Content/#go_SmallItem")
	self._gofilter = gohelper.findChild(self.viewGO, "root/#btn_filter")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Select")
	self._gonpcinfo = gohelper.findChild(self.viewGO, "root/go_manageinfo")
	self._btnCloseInfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_manageinfo/#btn_close")
end

function SurvivalNPCSelectView:addEvents()
	self._btnSelect:AddClickListener(self.changeQuickSelect, self)
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnCloseInfo:AddClickListener(self.closeInfo, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, self._refreshView, self)
end

function SurvivalNPCSelectView:removeEvents()
	self._btnSelect:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCloseInfo:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, self._refreshView, self)
end

function SurvivalNPCSelectView:onClickModalMask()
	self:closeThis()
end

function SurvivalNPCSelectView:onOpen()
	gohelper.setActive(self._gonpcitem, false)

	self._npcSelects = self:getUserDataTb_()
	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self._createNPCItem, self, nil, self._gonpcitem)
	self._simpleList:setRecycleCallBack(self._onCellRecycle, self)
	ZProj.UGUIHelper.SetGrayscale(self._btnSelect.gameObject, not isQuickSelect)
	gohelper.setActive(self._gonpcinfo, false)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self._gonpcinfo)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalSelectNPCInfoPart)

	self:initNPCData()

	local filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gofilter, SurvivalFilterPart)
	local filterOptions = {}
	local list = lua_survival_tag_type.configList

	for i, v in ipairs(list) do
		table.insert(filterOptions, {
			desc = v.name,
			type = v.id
		})
	end

	filterComp:setOptionChangeCallback(self._onFilterChange, self)
	filterComp:setOptions(filterOptions)

	if self.viewParam then
		local index = tabletool.indexOf(self._allNpcs, self.viewParam)

		if index then
			self._curSelectIndex = index

			gohelper.setActive(self._gonpcinfo, true)
			self._infoPanel:updateMo(self.viewParam)
			gohelper.setActive(self._npcSelects[self._curSelectIndex], true)
		end
	end
end

function SurvivalNPCSelectView:changeQuickSelect()
	isQuickSelect = not isQuickSelect

	ZProj.UGUIHelper.SetGrayscale(self._btnSelect.gameObject, not isQuickSelect)
	self:closeInfo()
end

function SurvivalNPCSelectView:initNPCData()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local inTeamList = {}
	local otherList = {}
	local initGroupMo = SurvivalMapModel.instance:getInitGroup()

	for _, npcMo in pairs(weekInfo.npcDict) do
		if npcMo then
			if tabletool.indexOf(initGroupMo.allSelectNpcs, npcMo) then
				table.insert(inTeamList, npcMo)
			else
				table.insert(otherList, npcMo)
			end
		end
	end

	tabletool.addValues(inTeamList, otherList)

	self._allNpcs = inTeamList
	self._initGroupMo = initGroupMo
end

function SurvivalNPCSelectView:_onFilterChange(filterList)
	self._filterList = filterList

	self:_refreshView()
end

function SurvivalNPCSelectView:_refreshView()
	self:closeInfo()

	local showMos = {}

	for _, npcMo in ipairs(self._allNpcs) do
		if SurvivalBagSortHelper.filterNpc(self._filterList, npcMo) and npcMo.co.takeOut == 0 then
			table.insert(showMos, npcMo)
		end
	end

	self._showMos = showMos

	tabletool.clear(self._npcSelects)
	self._simpleList:setList(showMos)
	gohelper.setActive(self._goempty, #showMos == 0)
	gohelper.setActive(self._goscroll, #showMos > 0)
end

function SurvivalNPCSelectView:_createNPCItem(obj, data, index)
	local imageNpc = gohelper.findChildSingleImage(obj, "#image_Chess")
	local imgNpcQuality = gohelper.findChildImage(obj, "#image_quality")
	local txtName = gohelper.findChildTextMesh(obj, "#txt_PartnerName")
	local goSelected = gohelper.findChild(obj, "#go_Selected")
	local goTips = gohelper.findChild(obj, "#go_Tips")
	local txtTips = gohelper.findChildTextMesh(obj, "#go_Tips/#txt_TentName")
	local recommend = gohelper.findChild(obj, "recommend")
	local btn = gohelper.findButtonWithAudio(obj)

	self._npcSelects[index] = goSelected
	txtName.text = data.co.name
	txtTips.text = luaLang("survival_npcselectview_inteam")

	UISpriteSetMgr.instance:setSurvivalSprite(imgNpcQuality, string.format("survival_bag_itemquality2_%s", data.co.rare))
	SurvivalUnitIconHelper.instance:setNpcIcon(imageNpc, data.co.headIcon)
	gohelper.setActive(goTips, tabletool.indexOf(self._initGroupMo.allSelectNpcs, data))
	self:removeClickCb(btn)
	self.addClickCb(self, btn, self._onClickNpc, self, index)
	gohelper.setActive(goSelected, self._curSelectIndex == index)

	local mapId = SurvivalMapModel.instance:getSelectMapId()

	gohelper.setActive(recommend, data:isRecommend(mapId))
end

function SurvivalNPCSelectView:_onCellRecycle(go, oldIndex, newIndex)
	self._npcSelects[oldIndex] = nil
end

function SurvivalNPCSelectView:_onClickNpc(index)
	if isQuickSelect then
		local npcMo = self._showMos[index]
		local initGroup = SurvivalMapModel.instance:getInitGroup()
		local isInTeam = tabletool.indexOf(initGroup.allSelectNpcs, npcMo)
		local isFull = tabletool.len(initGroup.allSelectNpcs) == initGroup:getCarryNPCCount()

		if isInTeam then
			tabletool.removeValue(initGroup.allSelectNpcs, npcMo)
			self:_refreshView()
		elseif not isFull then
			table.insert(initGroup.allSelectNpcs, npcMo)
			self:_refreshView()
		else
			GameFacade.showToast(ToastEnum.SurvivalNpcFull)

			return
		end
	end

	gohelper.setActive(self._npcSelects[self._curSelectIndex], false)

	self._curSelectIndex = index

	gohelper.setActive(self._npcSelects[self._curSelectIndex], true)
	gohelper.setActive(self._gonpcinfo, true)
	self._infoPanel:updateMo(self._showMos[index])
end

function SurvivalNPCSelectView:closeInfo()
	gohelper.setActive(self._npcSelects[self._curSelectIndex], false)

	self._curSelectIndex = nil

	gohelper.setActive(self._gonpcinfo, false)

	self._curSelect = false
end

return SurvivalNPCSelectView
