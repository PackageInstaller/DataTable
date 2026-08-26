-- chunkname: @modules/logic/survival/view/rewardinherit/SurvivalRewardInheritTab.lua

module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritTab", package.seeall)

local SurvivalRewardInheritTab = class("SurvivalRewardInheritTab", LuaCompBase)

function SurvivalRewardInheritTab:init(go)
	self.go = go
	self.btnClick = gohelper.findButtonWithAudio(go)
	self.image_Line = gohelper.findChild(go, "image_Line")
	self.txt_Common = gohelper.findChildTextMesh(go, "txt_Common")
	self.image_Icon = gohelper.findChildImage(go, "txt_Common/image_Icon")
	self.go_Selected = gohelper.findChild(go, "#go_Selected")
	self.select_txt_Common = gohelper.findChildTextMesh(self.go_Selected, "txt_Common")
	self.select_image_Icon = gohelper.findChildImage(self.go_Selected, "txt_Common/image_Icon")
	self.go_num = gohelper.findChild(go, "#go_num")
	self.textRedDot = gohelper.findChildTextMesh(go, "#go_num/#txt_num")
	self.image_Line = gohelper.findChild(go, "image_Line")

	self:setSelect(false)
end

function SurvivalRewardInheritTab:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
end

function SurvivalRewardInheritTab:setData(data)
	if data == nil then
		return
	end

	self.index = data.index
	self.handbookType = data.handbookType
	self.subType = data.subType
	self.onClickTabCallBack = data.onClickTabCallBack
	self.onClickTabContext = data.onClickTabContext
	self.isLast = data.isLast
	self.isTransflective = data.isTransflective

	gohelper.setActive(self.image_Line, not self.isLast)

	self.txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(self.handbookType, self.subType)
	self.select_txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(self.handbookType, self.subType)

	local path = SurvivalHandbookModel.instance:getTabImageBySubType(self.handbookType, self.subType)

	UISpriteSetMgr.instance:setSurvivalSprite(self.image_Icon, path)
	UISpriteSetMgr.instance:setSurvivalSprite(self.select_image_Icon, path)
	self:refreshAmount()

	local imageColor = self.image_Icon.color
	local txt_Common = self.txt_Common.color

	if self.isTransflective then
		self.image_Icon.color = Color.New(imageColor.r, imageColor.g, imageColor.b, 0.5)
		self.txt_Common.color = Color.New(txt_Common.r, txt_Common.g, txt_Common.b, 0.5)
	else
		self.image_Icon.color = Color.New(imageColor.r, imageColor.g, imageColor.b, 1)
		self.txt_Common.color = Color.New(txt_Common.r, txt_Common.g, txt_Common.b, 1)
	end
end

function SurvivalRewardInheritTab:refreshAmount()
	local amount = SurvivalRewardInheritModel.instance:getSelectNum(self.handbookType, self.subType)

	if amount > 0 then
		gohelper.setActive(self.go_num, true)

		self.textRedDot.text = amount
	else
		gohelper.setActive(self.go_num, false)
	end
end

function SurvivalRewardInheritTab:onClickBtnClick()
	if self.onClickTabCallBack then
		self.onClickTabCallBack(self.onClickTabContext, self)
	end
end

function SurvivalRewardInheritTab:setSelect(value)
	self.isSelect = value

	gohelper.setActive(self.go_Selected, self.isSelect)
end

return SurvivalRewardInheritTab
