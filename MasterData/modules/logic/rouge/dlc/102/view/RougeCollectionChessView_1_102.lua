-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionChessView_1_102.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionChessView_1_102", package.seeall)

local RougeCollectionChessView_1_102 = class("RougeCollectionChessView_1_102", BaseViewExtended)

RougeCollectionChessView_1_102.AssetUrl = "ui/viewres/rouge/dlc/102/rougecollectiontrammelview.prefab"
RougeCollectionChessView_1_102.ParentObjPath = "#go_left"

local ActiveTrammelColor = "#A08156"
local DisactiveTrammelColor = "#616161"
local ActiveTrammelAlpha = 1
local DisactiveTrammelAlpha = 0.6
local ActiveTrammelCountColor = "#A08156"
local DisactiveTrammelCountColor = "#616161"

function RougeCollectionChessView_1_102:onInitView()
	self._btntrammel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_trammel")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#btn_trammel/#image_icon")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_close")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_tips/go_content")
	self._godecitem = gohelper.findChild(self.viewGO, "#go_tips/#go_content/#txt_decitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_tips/#txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessView_1_102:addEvents()
	self._btntrammel:AddClickListener(self._btntrammelOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.AdjustBackPack, self._adjustBackPack, self)
end

function RougeCollectionChessView_1_102:removeEvents()
	self._btntrammel:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RougeCollectionChessView_1_102:_btntrammelOnClick()
	self._waitShowTips = true

	self:_tryGetTrammelInfoAndRefreshUI()
end

function RougeCollectionChessView_1_102:_tryGetTrammelInfoAndRefreshUI()
	local season = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeItemTrammelsRequest(season, self._sendRougeItemTrammelsRequestCallBack, self)
end

function RougeCollectionChessView_1_102:_sendRougeItemTrammelsRequestCallBack(_, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._activeIds = msg.ids
	self._activeIdMap = {}

	if self._activeIds then
		self._activeIdCount = #self._activeIds or 0
	end

	for _, id in ipairs(msg.ids) do
		self._activeIdMap[id] = true
	end

	gohelper.setActive(self._gotips, self._waitShowTips)
	self:_refreshUI()
end

function RougeCollectionChessView_1_102:_adjustBackPack()
	self:_tryGetTrammelInfoAndRefreshUI()
end

function RougeCollectionChessView_1_102:_btncloseOnClick()
	gohelper.setActive(self._gotips, false)

	self._waitShowTips = false
end

function RougeCollectionChessView_1_102:onOpen()
	self:_tryGetTrammelInfoAndRefreshUI()
end

function RougeCollectionChessView_1_102:_refreshUI()
	local trammelIconName = string.format("rouge_dlc2_icon" .. self._activeIdCount)

	UISpriteSetMgr.instance:setRouge4Sprite(self._imageicon, trammelIconName)

	local trammelCos = RougeDLCConfig102.instance:getAllCollectionTrammelCo()
	local trammelCountList = {}

	for _, trammelCo in ipairs(trammelCos) do
		if self._activeIdMap then
			local count = trammelCo.num

			if self._activeIdMap then
				if not ActiveTrammelCountColor then
					local countColor = DisactiveTrammelCountColor
					local countStr = string.format("<%s>%s</color>", countColor, count)

					table.insert(trammelCountList, countStr)
				end
			end
		end
	end

	local trammelCountStr = table.concat(trammelCountList, "/")

	self._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_trammels_title"), trammelCountStr)

	gohelper.CreateObjList(self, self.refreshTip, trammelCos, self._gocontent, self._godecitem)
end

function RougeCollectionChessView_1_102:refreshTip(obj, trammelCo, index)
	local txtdesc = obj:GetComponent(gohelper.Type_TextMesh)

	txtdesc.text = trammelCo.desc

	if self._activeIdMap then
		local isActive = self._activeIdMap[trammelCo.id]

		SLFramework.UGUI.GuiHelper:SetColor((isActive or nil) and (ActiveTrammelColor or DisactiveTrammelColor))
		ZProj.UGUIHelper:SetColorAlpha((isActive or nil) and (ActiveTrammelAlpha or DisactiveTrammelAlpha))
	end
end

return RougeCollectionChessView_1_102
