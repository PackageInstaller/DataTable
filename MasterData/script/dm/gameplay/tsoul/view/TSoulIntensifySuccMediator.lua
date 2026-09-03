-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulIntensifySuccMediator.lua

TSoulIntensifySuccMediator = class("TSoulIntensifySuccMediator", DmPopupViewMediator, _M)

TSoulIntensifySuccMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function TSoulIntensifySuccMediator:initialize()
	super.initialize(self)
end

function TSoulIntensifySuccMediator:dispose()
	super.dispose(self)
end

function TSoulIntensifySuccMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._tSoulSystem = self._developSystem:getTSoulSystem()

	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("TimeSoul_Main_SuitUI_14"),
		bgSize = {
			width = 840,
			height = 544
		}
	})

	self._btnOk = self:bindWidget("main.btn_ok", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onOkClicked, self)
		}
	})
end

function TSoulIntensifySuccMediator:enterWithData(data)
	self._tSoulId = data.tSoulId
	self._tSoulData = self._tSoulSystem:getTSoulById(self._tSoulId)
	self._tempTSoulData = self._tSoulSystem:getBeforeIntensifyInfo()

	self:setUpView()
end

function TSoulIntensifySuccMediator:setUpView()
	self._main = self:getView():getChildByFullName("main")

	local name = self._main:getChildByFullName("namelabel")
	local imgIcon = self._main:getChildByFullName("Image_icon")
	local imgRareity = self._main:getChildByFullName("Image_13")
	local curLv = self._main:getChildByFullName("text_nextLv")
	local beforeLv = self._main:getChildByFullName("text_lv")
	local panelAttr = self._main:getChildByFullName("Panel_attr")

	panelAttr:setVisible(false)
	imgIcon:ignoreContentAdaptWithSize(true)
	imgIcon:loadTexture(self._tSoulData:getIcon())
	imgIcon:setScale(0.8)
	name:setString(self._tSoulData:getName())
	imgRareity:loadTexture(KTSoulRareityName[self._tSoulData:getRarity()], 1)
	curLv:setString(Strings:get("RANK_LEVEL") .. "  " .. self._tSoulData:getLevel())
	beforeLv:setString(self._tempTSoulData.lv)

	local panelClone = panelAttr:clone()

	panelClone:setVisible(true)
	panelClone:addTo(self._main):posit(400, 352)

	local beforeAttrText = panelClone:getChildByFullName("text_attrName")
	local attrText = panelClone:getChildByFullName("text_attrAdd")
	local newAttr = panelClone:getChildByFullName("text_new")
	local newImg = panelClone:getChildByFullName("Image_2")
	local bastAttr = self._tSoulData:getBaseAttr()
	local beforeAttr = self._tempTSoulData.baseAttr

	newAttr:setVisible(false)
	newImg:setVisible(false)
	beforeAttrText:setString(getAttrNameByType(next(beforeAttr)) .. ":  " .. beforeAttr[next(beforeAttr)])
	attrText:setString(getAttrNameByType(next(beforeAttr)) .. ":  " .. bastAttr[next(bastAttr)])
	attrText:setTextColor(beforeAttr[next(beforeAttr)] == bastAttr[next(bastAttr)] and cc.c3b(255, 255, 255) or cc.c3b(160, 255, 75))

	local addAtrr = self._tSoulData:getAddAttr()
	local beforeAttr = self._tempTSoulData.addAttr
	local index = 1
	local listViewAttr = self._main:getChildByFullName("listView")

	listViewAttr:setScrollBarEnabled(false)
	listViewAttr:removeAllChildren()

	for k, v in pairs(addAtrr) do
		local panelClone = panelAttr:clone()

		panelClone:setVisible(true)

		local beforeAttrText = panelClone:getChildByFullName("text_attrName")
		local attrText = panelClone:getChildByFullName("text_attrAdd")
		local newAttr = panelClone:getChildByFullName("text_new")
		local newImg = panelClone:getChildByFullName("Image_2")
		local isPercent = AttributeCategory:getAttNameAttend(k) ~= ""

		if beforeAttr[k] then
			local beAttrNum = beforeAttr[k]
			local attrNum = v

			if isPercent then
				beAttrNum = beAttrNum * 100 .. "%"
				attrNum = attrNum * 100 .. "%"
			end

			beforeAttrText:setString(getAttrNameByType(k) .. ":  " .. beAttrNum)
			attrText:setString(getAttrNameByType(k) .. ":  " .. attrNum)
			newAttr:setVisible(false)
			newImg:setVisible(false)
			attrText:setTextColor(beforeAttr[k] == v and cc.c3b(255, 255, 255) or cc.c3b(160, 255, 75))
			panelClone:getChildByFullName("Image_28"):setVisible(beforeAttr[k] ~= v)
		else
			beforeAttrText:setString("")

			local attrNum = v

			if isPercent then
				attrNum = attrNum * 100 .. "%"
			end

			attrText:setString(getAttrNameByType(k) .. ":  " .. attrNum)
			attrText:setTextColor(cc.c3b(255, 211, 105))
			newAttr:setVisible(true)
			newImg:setVisible(true)
			newAttr:setPositionX(attrText:getPositionX() + attrText:getContentSize().width + 10)

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 241, 91, 255)
				}
			}
			local lineGradiantDir2 = {
				x = 0,
				y = -1
			}

			newAttr:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))
		end

		index = index + 1

		listViewAttr:pushBackCustomItem(panelClone)
	end
end

function TSoulIntensifySuccMediator:onOkClicked(sender, eventType)
	self:close()
end

function TSoulIntensifySuccMediator:onClickClose(sender, eventType)
	self:close()
end
