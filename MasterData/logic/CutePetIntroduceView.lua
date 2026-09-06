-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/introduce/CutePetIntroduceView.lua

module("logic.extensions.cutepet.view.introduce.CutePetIntroduceView", package.seeall)

local CutePetIntroduceView = class("CutePetIntroduceView", ViewComponent)
local TabType = {
	Child = 2,
	Parent = 1
}
local TabPage = {
	Tab1 = 1,
	Tab2 = 2
}

function CutePetIntroduceView:ctor()
	CutePetIntroduceView.super.ctor(self)
end

function CutePetIntroduceView:buildUI()
	CutePetIntroduceView.super.buildUI(self)

	self._btnClose = self:getBtn("topleft/btnClose")
	self._tab1 = self:getGo("tab1")
	self._tab2 = self:getGo("tab2")
	self._btnTab1 = self:getGo("btnTab1")
	self._btnRedPoint1 = self:getGo("btnTab1/redpoint")
	self._tab1Change = goutil.findChildComponent(self.mainGO, "btnTab1", "UIChangeGroup")
	self._btnTab2 = self:getGo("btnTab2")
	self._btnRedPoint2 = self:getGo("btnTab2/redpoint")
	self._tab2Change = goutil.findChildComponent(self.mainGO, "btnTab2", "UIChangeGroup")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self.clearTabCell, self))
	self._btn1 = self:getBtn("btn1")
	self._btn2 = self:getBtn("btn2")
	self._imgPet = self:getGo("tab2/imgPet")
	self._txtName = self:getTxt("tab2/txtName")
	self._txtDesc = self:getTxt("tab2/txtDesc")
	self._con = self:getGo("con")
	self._tableBg = self:getGo("imgTabBg")
end

function CutePetIntroduceView:bindEvents()
	CutePetIntroduceView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
	GameUtil.addClickHandler(self._btnTab1, self._onClickTabBtn1, self)
	GameUtil.addClickHandler(self._btnTab2, self._onClickTabBtn2, self)
end

function CutePetIntroduceView:unbindEvents()
	CutePetIntroduceView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnTab1)
	GameUtil.rmClickHandler(self._btnTab2)
end

function CutePetIntroduceView:onEnter()
	CutePetIntroduceView.super.onEnter(self)
	goutil.setActive(self._tab1, false)
	goutil.setActive(self._tab2, false)
	GameUtil.SetActive(self._btnRedPoint1, false)
	GameUtil.SetActive(self._btnRedPoint2, false)
	self:_initData()
	self._scrollList:reloadData(self._tabData)

	self._curSelectTab = nil

	self:_onClickTabBtn2()
end

function CutePetIntroduceView:onExit()
	CutePetIntroduceView.super.onExit(self)
	self._scrollList:dispose()
	RedPointController.instance:unregRedPoint(self._btnRedPoint1)
	RedPointController.instance:unregRedPoint(self._btnRedPoint2)
	GameUtil.SetActive(self._btnRedPoint1, false)
	GameUtil.SetActive(self._btnRedPoint2, false)
	uGuiUtil.clearImage(self._imgPet)
end

function CutePetIntroduceView:_initData()
	local cfgs = CutePetConfig.instance:getPetIntroduceCfgs()

	RedPointController.instance:regRedPoint(self._btnRedPoint1, cfgs[1].redId)
	RedPointController.instance:regRedPoint(self._btnRedPoint2, cfgs[2].redId)

	local tabPage = TabPage.Tab1

	self._tabData = {}

	for i, v in ipairs(cfgs) do
		if v.tabType == TabType.Child then
			table.insert(self._tabData, v)
		elseif tabPage == TabPage.Tab1 then
			if checknumber(v.redId) ~= 0 then
				RedPointController.instance:regRedPoint(self._btnRedPoint1, v.redId)
			else
				RedPointController.instance:unregRedPoint(self._btnRedPoint1)
				GameUtil.SetActive(self._btnRedPoint1, false)
			end

			tabPage = TabPage.Tab2
		elseif tabPage == TabPage.Tab2 then
			if checknumber(v.redId) ~= 0 then
				RedPointController.instance:regRedPoint(self._btnRedPoint2, v.redId)
			else
				RedPointController.instance:unregRedPoint(self._btnRedPoint2)
				GameUtil.SetActive(self._btnRedPoint2, false)
			end

			tabPage = TabPage.Tab3
		end
	end

	self._curChildTab = 1
end

function CutePetIntroduceView:_getInitTabList()
	local cfgs = CutePetConfig.instance:getPetIntroduceCfgs()
	local list = {}
	local dic = {}

	for i, v in ipairs(cfgs) do
		local tab = {}

		tab.cfg = v
		tab.tabType = v.tabType
		tab.isFold = true
		tab.isSelect = false
		tab.parentTab = nil
		tab.childTabs = {}
		dic[v.id] = tab

		table.insert(list, tab)
	end

	local isSelect = false
	local curSelectTab

	for i, v in ipairs(list) do
		if v.tabType == TabType.Parent then
			v.isFold = true

			if not isSelect then
				isSelect = true
				v.isSelect = true
				curSelectTab = v
			end
		end

		if v.tabType == TabType.Child then
			local tabParent = dic[v.cfg.parentId]

			v.parentTab = tabParent

			table.insert(tabParent.childTabs, v)
		end
	end

	return list, curSelectTab
end

function CutePetIntroduceView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local txtNameColorChange = txtName:GetComponent(ComponentType.UITextColorChange)
	local imgBgSpriteChange = goutil.findChild(cell, "btn/imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgSmallBgSpriteChange = goutil.findChild(cell, "btn/imgSmallBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local redPoint = goutil.findChild(cell.gameObject, "redpoint")

	txtName.text = data.cfg.tabName

	local index = data.isSelect and 1 or 0

	if data.tabType == TabType.Parent then
		goutil.setActive(imgSmallBgSpriteChange.gameObject, false)
		goutil.setActive(imgBgSpriteChange.gameObject, true)
		imgBgSpriteChange:SetState(index)

		local colorIndex = data.isSelect and 1 or 0

		txtNameColorChange:SetState(colorIndex)
	else
		goutil.setActive(imgSmallBgSpriteChange.gameObject, true)
		goutil.setActive(imgBgSpriteChange.gameObject, false)
		imgSmallBgSpriteChange:SetState(index)

		local colorIndex = data.isSelect and 3 or 2

		txtNameColorChange:SetState(colorIndex)
	end

	if data.isSelect then
		self:_updateTabPage(data)
	end

	if checknumber(data.cfg.redId) ~= 0 then
		RedPointController.instance:regRedPoint(redPoint, data.cfg.redId)
	else
		RedPointController.instance:unregRedPoint(redPoint)
		GameUtil.SetActive(redPoint, false)
	end

	btn:AddClickListener(function()
		if data.tabType == TabType.Parent and checknumber(data.cfg.redId) ~= 0 then
			RedPointController.instance:saveUserDayRedPoint(data.cfg.redId)
		end

		self:_updateSelectTab(data)
	end)
end

function CutePetIntroduceView:clearCell(cell)
	local redPoint = goutil.findChild(cell.gameObject, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function CutePetIntroduceView:_updateSelectTab(tabData)
	for i, v in ipairs(self._curTabList) do
		if v == tabData then
			if v.isSelect then
				if v.tabType == TabType.Parent then
					v.isFold = not v.isFold
				end
			else
				v.isSelect = true

				if v.tabType == TabType.Parent then
					v.isFold = false
				end
			end
		elseif v.tabType == TabType.Parent then
			local index = table.indexof(v.childTabs, tabData)

			if index then
				v.isSelect = true
				v.isFold = false
			else
				v.isSelect = false
				v.isFold = true
			end
		else
			v.isSelect = false
		end
	end

	local list = {}

	for i, v in ipairs(self._curTabList) do
		if v.tabType == TabType.Parent then
			table.insert(list, v)

			if not v.isFold then
				local isSelectChild = false

				for k, v1 in ipairs(v.childTabs) do
					if v1.isSelect then
						isSelectChild = true
					end

					table.insert(list, v1)
				end

				if not isSelectChild and #v.childTabs > 0 then
					v.childTabs[1].isSelect = true
				end
			end
		end
	end

	printInfo("CutePetIntroduceView:_updateSelectTab(tabData)1", tabData.cfg.id, tabData.cfg.tabName)

	for i, v in ipairs(list) do
		printInfo("CutePetIntroduceView:_updateSelectTab(tabData)2", i, v.cfg.id, v.cfg.tabName, v.tabType, v.isSelect, v.isFold, #v.childTabs)
	end

	self._scrollList:reloadData(list)
end

function CutePetIntroduceView:_updateTabPage(tabData)
	if tabData.tabType == TabType.Parent then
		if tabData.cfg.id == TabPage.Tab1 then
			goutil.setActive(self._tab1, true)
			goutil.setActive(self._tab2, false)

			self._petObj = RoleObjectPool.instance:addRoleToParent(self._petObj, 10140, self._con)
		elseif tabData.cfg.id == TabPage.Tab2 then
			goutil.setActive(self._tab1, false)
			goutil.setActive(self._tab2, true)

			self._petObj = RoleObjectPool.instance:removeRole(self._petObj)
		end
	elseif tabData.tabType == TabType.Child then
		local parentTab = tabData.parentTab

		if parentTab.cfg.id == TabPage.Tab2 then
			self:_updateTab2(tabData)
		end
	end
end

function CutePetIntroduceView:_updateTab1()
	return 0
end

function CutePetIntroduceView:_updateTab2(tabData)
	self._txtName.text = "宠物秘案：" .. tabData.cfg.title
	self._txtDesc.text = tabData.cfg.desc

	uGuiUtil.setSpriteToImage(self._imgPet, uGuiUtil.SpriteType.BigBg, tabData.cfg.imagePath)
end

function CutePetIntroduceView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local imgBg = goutil.findChild(go, "imgBg")
	local btn = goutil.findChild(go, "btn")

	txtName.text = data.title

	GameUtil.SetActive(imgBg, data.raceId == self._curChildTab)
	GameUtil.addClickHandler(btn, function()
		self:_onClickTab2Child(data.raceId)
	end, self)
end

function CutePetIntroduceView:clearTabCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function CutePetIntroduceView:_refreshTabBtn()
	if self._curSelectTab == TabPage.Tab1 then
		self._tab1Change:SetState(0)
		self._tab2Change:SetState(1)
	else
		self._tab1Change:SetState(1)
		self._tab2Change:SetState(0)
	end
end

function CutePetIntroduceView:_onClickBtn1()
	GotoMgr.gotoByString("func#915")
end

function CutePetIntroduceView:_onClickBtn2()
	GotoMgr.gotoByString("func#910")
end

function CutePetIntroduceView:_onClickTabBtn1()
	if self._curSelectTab ~= TabPage.Tab1 then
		RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_CUTEPET_INTRODUCE_TAB_1)
		GameUtil.SetActive(self._tab1, true)
		GameUtil.SetActive(self._tab2, false)
		GameUtil.SetActive(self._tableBg, false)
		GameUtil.SetActive(self.scrollerGo, false)

		self._petObj = RoleObjectPool.instance:addRoleToParent(self._petObj, 10140, self._con)
		self._curSelectTab = TabPage.Tab1

		self:_refreshTabBtn()
	end
end

function CutePetIntroduceView:_onClickTabBtn2()
	if self._curSelectTab ~= TabPage.Tab2 then
		RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_CUTEPET_INTRODUCE_TAB_2)
		GameUtil.SetActive(self._tab1, false)
		GameUtil.SetActive(self._tab2, true)
		GameUtil.SetActive(self._tableBg, true)
		GameUtil.SetActive(self.scrollerGo, true)

		self._petObj = RoleObjectPool.instance:removeRole(self._petObj)
		self._curSelectTab = TabPage.Tab2

		self:_refreshTab2()
		self._scrollList:refresh()
		self:_refreshTabBtn()
	end
end

function CutePetIntroduceView:_onClickTab2Child(index)
	self._curChildTab = index

	self:_refreshTab2()
	self._scrollList:refresh()
end

function CutePetIntroduceView:_refreshTab2()
	local cfg = self._tabData[self._curChildTab]

	self._txtName.text = cfg.title
	self._txtDesc.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._imgPet, uGuiUtil.SpriteType.BigBg, cfg.imagePath)
end

return CutePetIntroduceView
