-- chunkname: @modules/logic/gm/view/GMLangTxtView.lua

module("modules.logic.gm.view.GMLangTxtView", package.seeall)

local GMLangTxtView = class("GMLangTxtView", BaseView)
local StateShow = 1
local StateHide = 2
local StateTweening = 3

function GMLangTxtView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnHide")
	self._btnDelete = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnDelete")
	self._rect = gohelper.findChild(self.viewGO, "view").transform
	self._inputSearch = gohelper.findChildTextMeshInputField(self.viewGO, "view/title/InputField")
	self._dropLangChange = gohelper.findChildDropdown(self.viewGO, "view/title/dropdown_lang")

	local _goLangItem = gohelper.findChild(self.viewGO, "view/right/scroll/Viewport/content/item")

	self._goLangItemList = {}

	local cSharpArr = GameConfig:GetSupportedLangs()
	local length = cSharpArr.Length

	self.supportLangs = {}

	for i = 0, length - 1 do
		table.insert(self.supportLangs, LangSettings.shortcutTab[cSharpArr[i]])

		local item = GMLangTxtLangItem.New()

		item:init(gohelper.cloneInPlace(_goLangItem, "item"), LangSettings.shortcutTab[cSharpArr[i]])
		table.insert(self._goLangItemList, item)
	end

	self._dropLangChange:ClearOptions()
	self._dropLangChange:AddOptions(self.supportLangs)

	local curLang = LangSettings.instance:getCurLangShortcut()

	for i = 1, #self.supportLangs do
		if self.supportLangs[i] == curLang then
			self._dropLangChange:SetValue(i - 1)

			break
		end
	end
end

function GMLangTxtView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._inputSearch:AddOnValueChanged(self._onSearchValueChanged, self)
	self._inputSearch:AddOnEndEdit(self._onSearchEndEdit, self)
	self._dropLangChange:AddOnValueChanged(self._onLangChange, self)
end

function GMLangTxtView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnDelete:RemoveClickListener()

	if self._inputSearch then
		self._inputSearch:RemoveOnValueChanged()
		self._inputSearch:RemoveOnEndEdit()
	end

	self._dropLangChange:RemoveOnValueChanged()
end

function GMLangTxtView:onOpen()
	self._state = StateShow

	self:_updateBtns()
end

function GMLangTxtView:onClose()
	for i, item in ipairs(self._goLangItemList) do
		item:onClose()
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function GMLangTxtView:_onClickShow()
	if self._state == StateHide then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function GMLangTxtView:_onShow()
	self._tweenId = nil
	self._state = StateShow

	self:_updateBtns()
end

function GMLangTxtView:_onClickHide()
	if self._state == StateShow then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, -1740, 0.2, self._onHide, self)
	end
end

function GMLangTxtView:_onClickDelete()
	GMLangController.instance:clearInUse()
end

function GMLangTxtView:_onSearchValueChanged(value)
	GMLangTxtModel.instance:setSearch(value)
end

function GMLangTxtView:_onSearchEndEdit(value)
	return
end

function GMLangTxtView:_onHide()
	self._tweenId = nil
	self._state = StateHide

	self:_updateBtns()
end

function GMLangTxtView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == StateHide)
	gohelper.setActive(self._btnHide.gameObject, self._state == StateShow)
end

function GMLangTxtView:_onLangChange(index)
	local selectLang = self.supportLangs[index + 1]
	local root = ViewMgr.instance:getUIRoot()
	local inUseDic = GMLangController.instance:getInUseDic()
	local listTMP = root:GetComponentsInChildren(gohelper.Type_TextMesh, true)

	for i = 0, listTMP.Length - 1 do
		local tmpText = listTMP[i]
		local txt = tmpText.text
		local data = inUseDic[txt]

		if data then
			tmpText.text = data[selectLang]
		end
	end

	GMLangController.instance:changeLang(selectLang)

	local tmpPathDic = {}
	local listImg = root:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true)

	for i = 0, listImg.Length - 1 do
		local img = listImg[i]

		tmpPathDic[img] = img.curImageUrl

		img:UnLoadImage()
	end

	SLFramework.UnityHelper.ResGC()

	for img, path in pairs(tmpPathDic) do
		if not string.nilorempty(path) then
			img:LoadImage(path)
		end
	end
end

function GMLangTxtView:onLangTxtClick(langStr)
	for i, item in ipairs(self._goLangItemList) do
		item:updateStr(langStr)
	end
end

return GMLangTxtView
