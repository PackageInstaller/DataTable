-- chunkname: @modules/logic/summon/view/SummonPoolDetailView.lua

module("modules.logic.summon.view.SummonPoolDetailView", package.seeall)

local SummonPoolDetailView = class("SummonPoolDetailView", BaseView)

function SummonPoolDetailView:onInitView()
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._txtinfotitle = gohelper.findChildText(self.viewGO, "info/#txt_infotitle")
	self._txtinfotitleEn = gohelper.findChildText(self.viewGO, "info/#txt_infotitle/#txt_infotitleEn")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._gospecialtitle = gohelper.findChild(self.viewGO, "info/#go_specialtitle")
	self._txtspecialtitlecn = gohelper.findChildText(self.viewGO, "info/#go_specialtitle/#txt_specialtitlecn")
	self._goline = gohelper.findChild(self.viewGO, "#go_line")
	self._txttitlecn = gohelper.findChildText(self.viewGO, "#txt_titlecn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolDetailView:addEvents()
	self._btnclose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, self._refreshTitle, self)
end

function SummonPoolDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, self._refreshTitle, self)
end

function SummonPoolDetailView:_editableInitView()
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	self._txttitleen = gohelper.findChildText(self._txttitlecn.gameObject, "titleen")
	self._gotitleline = gohelper.findChild(self._txttitlecn.gameObject, "Line")
end

function SummonPoolDetailView:_refreshTitle(index)
	gohelper.setActive(self._txtinfotitle.gameObject, index ~= 1)
	gohelper.setActive(self._gospecialtitle, index == 1)

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local nameCn, nameEn
	local showEn = true

	if not self._summonSimulationActId then
		nameCn = poolCo.nameCn
		nameEn = poolCo.nameEn
	else
		local summonSimulationConfig = SummonSimulationPickConfig.instance:getSummonConfigById(self._summonSimulationActId)
		local itemConfig = ItemConfig.instance:getItemCo(summonSimulationConfig.itemId)

		nameCn = itemConfig.name
		nameEn = ""
		showEn = false
	end

	if index ~= 1 then
		self._txtinfotitle.text = SummonPoolDetailCategoryListModel.getName(index)
		self._txtinfotitleEn.text = SummonPoolDetailCategoryListModel.getNameEn(index)
	else
		local first, remain = self:_splitTitle2Part(nameCn, 1)

		self._txtspecialtitlecn.text = string.format("<size=60>%s</size>%s", first, remain)
	end

	local ruleDetailDesc = luaLang("ruledetail")

	self._txttitlecn.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("summon_pool_exchange"), nameCn, ruleDetailDesc)

	if showEn then
		self._txttitleen.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("summon_pool_exchange"), nameEn, "Rules")
	end

	gohelper.setActive(self._gotitleline, showEn)
	gohelper.setActive(self._txttitleen, showEn)
	self:_refreshline(index)
end

function SummonPoolDetailView:_splitTitle2Part(content, firtPartCount)
	firtPartCount = firtPartCount or 1

	if string.nilorempty(content) or firtPartCount >= GameUtil.utf8len(content) then
		return content, ""
	end

	local first = GameUtil.utf8sub(content, 1, firtPartCount)

	return first, (GameUtil.utf8len(content) >= firtPartCount + 1 or nil) and GameUtil.utf8sub(content, firtPartCount + 1, GameUtil.utf8len(content) - firtPartCount)
end

function SummonPoolDetailView:_refreshUI()
	local poolDetailConfig = SummonConfig.instance:getPoolDetailConfig(self._poolDetailId)

	SummonPoolDetailCategoryListModel.instance:initCategory()
	self.viewContainer._views[1]:selectCell(1, true)
end

function SummonPoolDetailView:_refreshline(index)
	if index ~= 1 then
		gohelper.setActive(self._goline, true)

		return
	end

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local isProbUp = SummonMainModel.isProbUp(poolCo)

	gohelper.setActive(self._goline, not isProbUp)
end

function SummonPoolDetailView:onUpdateParam()
	self:_initData()
end

function SummonPoolDetailView:onOpen()
	self:_initData()
end

function SummonPoolDetailView:_initData()
	self._poolId = self.viewParam.poolId
	self._luckyBagId = self.viewParam.luckyBagId
	self._summonSimulationActId = self.viewParam.summonSimulationActId

	SummonPoolDetailCategoryListModel.instance:setJumpLuckyBag(self._luckyBagId)
	self:_refreshUI()
	self:_refreshTitle(1)
	SummonController.instance:statViewPoolDetail(self._poolId)
	SummonController.instance:setPoolInfo(self.viewParam)
end

function SummonPoolDetailView:_btnCloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function SummonPoolDetailView:onClose()
	SummonController.instance:statExitPoolDetail()
end

function SummonPoolDetailView:onDestroyView()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

function SummonPoolDetailView:onClickModalMask()
	self:closeThis()
end

return SummonPoolDetailView
