-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsHandBookView.lua

module("logic.extensions.petshandbook.view.PetsHandBookView", package.seeall)

local PetsHandBookView = class("PetsHandBookView", ViewComponent)

function PetsHandBookView:ctor()
	PetsHandBookView.super.ctor(self)
	NotifyDispatcher.extend(self)

	self._petsItems = {}
	self._attrBtn = {}
	self._jobBtn = {}
	self._pageNum = 0
end

function PetsHandBookView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._Btn_Pre:AddClickListener(self._onClickPre, self)
	self._Btn_Next:AddClickListener(self._onClickNext, self)
	self._Btn_tujian:AddClickListener(self._onclickTujian, self)
	self._Btn_God:AddClickListener(self._onClickGod, self)
	self._btnClearSearch:AddClickListener(self._onClickClearSearch, self)
	self._InputC_Search:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function PetsHandBookView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._Btn_Pre:RemoveClickListener()
	self._Btn_Next:RemoveClickListener()
	self._Btn_tujian:RemoveClickListener()
	self._Btn_God:RemoveClickListener()
	self._btnClearSearch:RemoveListener()
	self._InputC_Search:RemoveOnValueChanged()
	self:removeAllListener("OnPetSelect")

	for i, v in ipairs(self._attrBtn) do
		v:unEvent()
	end

	for i, v in ipairs(self._jobBtn) do
		v:unEvent()
	end
end

function PetsHandBookView:buildUI()
	self._closeButton = self:getBtn("lefttop/btnClose")
	self._btnHelp = self:getBtn("lefttop/btnHelp")
	self._Container_Pets = self:getGo("center/Container_Pets")

	local goCenter = self:getGo("center")

	self._Btn_Pre = self:getBtn("center/Btn_Pre")
	self._Btn_Next = self:getBtn("center/Btn_Next")
	self._InputC_Search = self:getInput("center/InputC_Search")
	self._Btn_tujian = self:getBtn("center/Btn_tujian")
	self._btnClearSearch = self:getBtn("center/InputC_Search/btnClearSearch")
	self._txtLeftPage = goutil.findChildComponent(self.mainGO, "center/txtLeftPage", "Text")
	self._txtRightPage = goutil.findChildComponent(self.mainGO, "center/txtRightPage", "Text")

	local goProgress = self:getGo("center/progress")

	self._imgProgress = goutil.findChildComponent(goProgress, "imgProgress", "Image")
	self._txtProgress = goutil.findChildComponent(goProgress, "txtProgress", "Text")
	self._Btn_God = self:getBtn("Btn_God")
	self._Btn_God_Img = self:getGo("Btn_God/Image"):GetComponent("UIImageSpriteChange")
	self._cloneCell = self:getGo("center/item_pet")
end

function PetsHandBookView:destroyUI()
	return
end

function PetsHandBookView:onEnter()
	print("on onEnter handboobkview")
	self.mainGO:SetActive(false)
	self:_onClickClearSearch()

	if not PetsHandBookModel.instance:getIsDataInit() then
		HandbookAgent.instance:sendUserPetManualInfoReq()
	else
		self:_onInitView()
	end

	GlobalDispatcher:addListener(GlobalNotify.HandBookInit, self._onInitView, self)
end

function PetsHandBookView:_onInitView()
	self:_initAttributeBtn()
	self:_initJobBtn()
	self:_initPets()
	self:_onInitPageNum()
	self:_initCollectProgress()
	self:_justForCeTest()
	self.mainGO:SetActive(true)

	local curPageNum = PetsHandBookModel.instance:getCurPage()

	goutil.setActive(self._Btn_Pre.gameObject, curPageNum > 2)
	goutil.setActive(self._Btn_Next.gameObject, curPageNum < PetsHandBookModel.instance:getPages())
end

function PetsHandBookView:_justForCeTest()
	local Job_Group = self:getGo("Job_Group")

	Job_Group:SetActive(false)

	local Attr_Group = self:getGo("Attr_Group")

	Attr_Group:SetActive(false)

	local Btn_God = self:getGo("Btn_God")

	Btn_God:SetActive(false)
end

function PetsHandBookView:onEnterFinished()
	return
end

function PetsHandBookView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.HandBookInit, self._onInitView, self)
end

function PetsHandBookView:onExitFinished()
	return
end

function PetsHandBookView:_onClickClose()
	UIStateManager.instance:pop()
end

function PetsHandBookView:resetAtrButton()
	return
end

function PetsHandBookView:resetJobButton(jobType)
	return
end

function PetsHandBookView:_initAttributeBtn()
	if self._attrBtn then
		self._attrBtn = nil
		self._attrBtn = {}
	end

	local function selectFunc(raceType)
		self:resetAtrButton()
		self:_selectFunc(raceType)
	end

	local function unSelectFunc(raceType)
		self:_unSelectFunc(raceType)
	end

	local attr_name = {
		"光",
		"草",
		"火",
		"水",
		"暗"
	}
	local atrr_path = {
		"Job_Group/Btn_Guan",
		"Job_Group/Btn_Cao",
		"Job_Group/Btn_Huo",
		"Job_Group/Btn_Shui",
		"Job_Group/Btn_An"
	}

	for i = 1, #attr_name do
		local attributeBtn = Framework.LuaComponentContainer.Add(self:getGo(atrr_path[i]), AttributeBtn)

		attributeBtn:setAtrribute(GameEnum.Races[attr_name[i]])
		attributeBtn:setCallBackFunc(selectFunc, unSelectFunc)
		table.insert(self._attrBtn, attributeBtn)
	end
end

function PetsHandBookView:_initJobBtn()
	if self._jobBtn then
		self._jobBtn = nil
		self._jobBtn = {}
	end

	local function callBackFun(jobType, select)
		self:resetJobButton(jobType)
		self:_jobSelectFunc(jobType, select)
	end

	local job_name = {
		"利爪",
		"魔法",
		"急速",
		"肉盾",
		"平衡",
		"治疗"
	}

	for i, v in ipairs(job_name) do
		local jobBtn = Framework.LuaComponentContainer.Add(self:getGo("Attr_Group/Btn_" .. i), JobButton)

		jobBtn:setJobType(GameEnum.JobZh[v])
		jobBtn:setCallBack(callBackFun)
		table.insert(self._jobBtn, jobBtn)
	end
end

function PetsHandBookView:_initPets()
	if #PetsHandBookModel.instance:getPetItem() > 0 then
		self:refreshPage(nil, true)

		return nil
	end

	local hang = PetsHandBookModel.instance._hang
	local lie = PetsHandBookModel.instance._lie
	local itemNum = PetsHandBookModel.instance._itemNum

	for i = 1, hang do
		for j = 1, lie do
			local item_pet = goutil.cloneAndSetParent(self._cloneCell, self._Container_Pets.transform)

			item_pet.transform.localPosition = Vector3.New(-487 + (j - 1) * 95, 180 - (i - 1) * 95 - 33, 0)

			item_pet.gameObject:SetActive(true)

			local petsItem = PetsItemView.AddOnce(item_pet)

			petsItem:Init(PetsHandBookModel.instance:getPetCfgFilter()[j + (i - 1) * lie])
			PetsHandBookModel.instance:addPetItem(petsItem)
			petsItem:addListener(ItemPet.Events.Click, function(data)
				self:_OnClickPet(data)
			end)
			self:addListener("OnPetSelect", function(newData)
				petsItem:OnSelectPetChanged(newData)
			end)
		end
	end

	self._pageNum = itemNum

	for i = 1, hang do
		for j = 1, lie do
			local item_pet = goutil.cloneAndSetParent(self._cloneCell, self._Container_Pets.transform)

			item_pet.transform.localPosition = Vector3.New(69 + (j - 1) * 95, 180 - (i - 1) * 95 - 33, 0)

			item_pet.gameObject:SetActive(true)

			local petsItem = PetsItemView.AddOnce(item_pet)

			petsItem:Init(PetsHandBookModel.instance:getPetCfgFilter()[itemNum + j + (i - 1) * lie])
			PetsHandBookModel.instance:addPetItem(petsItem)
			petsItem:addListener(ItemPet.Events.Click, function(data)
				self:_OnClickPet(data)
			end)
			self:addListener("OnPetSelect", function(newData)
				petsItem:OnSelectPetChanged(newData)
			end)
		end
	end
end

function PetsHandBookView:refreshPage(pre, cur)
	local curPageNum = PetsHandBookModel.instance:getCurPage()

	goutil.setActive(self._Btn_Pre.gameObject, curPageNum > 2)
	goutil.setActive(self._Btn_Next.gameObject, curPageNum < PetsHandBookModel.instance:getPages())
	print("当前页是 ：", curPageNum)

	curPageNum = curPageNum - 2

	local hang = PetsHandBookModel.instance._hang
	local lie = PetsHandBookModel.instance._lie

	for i = 1, hang do
		for j = 1, lie do
			local petItem = PetsHandBookModel.instance:getPetItem(j + (i - 1) * lie)

			petItem:Init(PetsHandBookModel.instance:getPetCfgFilter()[curPageNum * self._pageNum + j + (i - 1) * lie])
		end
	end

	for i = 1, hang do
		for j = 1, lie do
			local petItem = PetsHandBookModel.instance:getPetItem(self._pageNum + j + (i - 1) * lie)

			petItem:Init(PetsHandBookModel.instance:getPetCfgFilter()[(curPageNum + 1) * self._pageNum + j + (i - 1) * lie])
		end
	end

	self:_onInitPageNum()
	self:_initCollectProgress()
end

function PetsHandBookView:_onClickPre()
	if PetsHandBookModel.instance:getCurPage() <= 2 then
		return nil
	end

	PetsHandBookModel.instance:setPrePage()
	self:refreshPage(true)
	self:_onInitPageNum()
end

function PetsHandBookView:_onClickNext()
	if PetsHandBookModel.instance:getCurPage() >= PetsHandBookModel.instance:getPages() then
		return nil
	end

	PetsHandBookModel.instance:setNextPage()
	self:refreshPage()
	self:_onInitPageNum()
end

function PetsHandBookView:_selectFunc(raceType)
	PetsHandBookModel.instance:setSelectAttr(raceType)
	PetsHandBookModel.instance:resetPage()
	self:refreshPage(nil, true)
end

function PetsHandBookView:_unSelectFunc(raceType)
	PetsHandBookModel.instance:setSelectAttr(raceType, -1)
	PetsHandBookModel.instance:resetPage()
	self:refreshPage(nil, true)
end

function PetsHandBookView:_jobSelectFunc(jobType, select)
	if not select then
		PetsHandBookModel.instance:setSelectJob(jobType)
	else
		PetsHandBookModel.instance:setSelectJob(jobType, -1)
	end

	PetsHandBookModel.instance:resetPage()
	self:refreshPage(nil, true)
end

function PetsHandBookView:_OnClickPet(data)
	UIStateManager.instance:open("petDetailView", data.raceId)
	self:dispatch("OnPetSelect", data)
end

function PetsHandBookView:_OnSearchTextChanged()
	local text = self._InputC_Search:GetText()

	PetsHandBookModel.instance:setSearchText(text)
	PetsHandBookModel.instance:resetPage()
	PetsHandBookModel.instance:getPetCfgFilter(true)
	self:refreshPage(nil, true)
	goutil.setActive(self._btnClearSearch.gameObject, not string.nilorempty(text))
end

function PetsHandBookView:_onInitPageNum()
	self._txtLeftPage.text = tostring(PetsHandBookModel.instance:getCurPage() - 1) .. "/" .. PetsHandBookModel.instance:getPages()
	self._txtRightPage.text = tostring(PetsHandBookModel.instance:getCurPage()) .. "/" .. PetsHandBookModel.instance:getPages()
end

function PetsHandBookView:_onclickTujian()
	UIStateManager.instance:push("petsPhotograph")
end

function PetsHandBookView:_initCollectProgress()
	self._txtProgress.text = #PetsHandBookModel.instance:getPetInfoList() .. "/" .. #PetsHandBookModel.instance:getPetCfgFilter()

	local denominator = math.max(#PetsHandBookModel.instance:getPetCfgFilter(), 1)

	self._imgProgress.fillAmount = #PetsHandBookModel.instance:getPetInfoList() / denominator
end

function PetsHandBookView:_onClickGod()
	local selectGod = PetsHandBookModel.instance:setSelectGod()

	PetsHandBookModel.instance:resetPage()
	self:refreshPage(nil, true)

	if selectGod then
		self._Btn_God_Img:SetState(1)
	else
		self._Btn_God_Img:SetState(0)
	end
end

function PetsHandBookView:_onClickClearSearch()
	self._InputC_Search:SetText("")
	goutil.setActive(self._btnClearSearch.gameObject, false)
end

function PetsHandBookView:_onClickBtnHelp()
	UIStateManager.instance:open(ViewName.PanelGuide, GameEnum.PanelGuideType.PetsHandBook)
end

return PetsHandBookView
