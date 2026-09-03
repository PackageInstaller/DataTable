-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeGuideTipMediator.lua

StagePracticeGuideTipMediator = class("StagePracticeGuideTipMediator", DmPopupViewMediator, _M)

StagePracticeGuideTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function StagePracticeGuideTipMediator:initialize()
	super.initialize(self)
end

function StagePracticeGuideTipMediator:dispose()
	super.dispose(self)
end

function StagePracticeGuideTipMediator:userInject()
	return
end

function StagePracticeGuideTipMediator:onRegister()
	super.onRegister(self)
end

function StagePracticeGuideTipMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByName("bgNode")
	local title = Strings:get("StagePractice_Text6")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = bind1(self.onClickOkBtn, self),
		title = Strings:get("StagePractice_Text6"),
		bgSize = {
			width = 1098,
			height = 573
		}
	})

	self._listView = self._main:getChildByName("listview")

	self._listView:setLocalZOrder(99999)
	self._listView:setScrollBarEnabled(false)

	self._picnode = self._main:getChildByName("panel")

	local bgImg = self._picnode:getChildByFullName("bg")

	bgImg:loadTexture("asset/ui/stagePractice/img_xunlian_bg.png")

	if #data.SpecialRules > 0 then
		self:addTitlePanel(Strings:get("StagePracticeGuideTitle2_Text"))

		for i = 1, #data.SpecialRules do
			self:addDescPanel(Strings:get(data.SpecialRules[i], {
				fontName = TTF_FONT_FZYH_M
			}))
		end
	end

	if #data.Guidance > 0 then
		self:addTitlePanel(Strings:get("StagePracticeGuideTitle1_Text"))

		for i = 1, #data.Guidance do
			self:addDescPanel(Strings:get(data.Guidance[i], {
				fontName = TTF_FONT_FZYH_M
			}))
		end
	end

	local textWaves = self._picnode:getChildByFullName("text_waves")

	textWaves:setString(Strings:get("StagePractice_Text11", {
		factor = data.WaveCount
	}))
	self:addEnemyInfo(data.GuidanceEnemy)
	textWaves:enableShadow(cc.c4b(0, 0, 0, 117.30000000000001), cc.size(-2, -4), 4)
end

function StagePracticeGuideTipMediator:addEnemyInfo(stageEnemy)
	for index, value in pairs(stageEnemy) do
		if value ~= "EMPTY" then
			local pos = self._picnode:getChildByName("pos" .. index)

			pos:loadTexture("img_buzhen_xuanzhong.png", 1)

			local config = ConfigReader:getRecordById("StageEnemy", stageEnemy[index])
			local heroType = config.Type
			local animName = GameStyle:getHeroCircleAnimName(heroType)
			local anim = cc.MovieClip:create(animName)
			local loopAni = anim:getChildByName("loop")

			loopAni:stop()
			anim:setScale(1.2)
			anim:addTo(pos, 1):center(pos:getContentSize()):offset(10, 10)

			local img = cc.Sprite:createWithSpriteFrameName(GameStyle:getHeroTypeTitlePath(heroType))

			img:setAnchorPoint(0, 0)
			img:setFlippedX(true)
			img:setScale(1.5)
			img:addTo(pos, 2):posite(4, 3)

			local rolePic = RoleFactory:createRoleAnimation(config.BattleModel)

			rolePic:getAnim():pauseAnimation()
			rolePic:setScale(0.6)
			rolePic:addTo(pos, 1):center(pos:getContentSize()):offset(10, 10)
		end
	end
end

function StagePracticeGuideTipMediator:addTitlePanel(titleStr)
	local icon = cc.Sprite:createWithSpriteFrameName("bg_common_biaotidi01.png")
	local panel = ccui.Layout:create()

	panel:setSwallowTouches(false)

	local data = string.split(titleStr, "<font")

	if #data <= 1 then
		text = Strings:get("StagePracticeGuideDesc1_Text", {
			desc = titleStr,
			fontName = TTF_FONT_FZYH_M
		})
	end

	local offsetX = 20
	local label = ccui.RichText:createWithXML(text, {})

	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 0.5))
	label:renderContent()
	panel:setContentSize(cc.size(443, icon:getContentSize().height + 10))
	icon:addTo(panel):center(panel:getContentSize()):offset(-1 + offsetX, 0)
	label:addTo(panel):posite(-6 + offsetX, 24)
	self._listView:pushBackCustomItem(panel)
end

function StagePracticeGuideTipMediator:addDescPanel(str)
	local width = 500
	local panel = ccui.Layout:create()

	panel:setSwallowTouches(false)

	local data = string.split(str, "<font")

	if #data <= 1 then
		str = Strings:get("StagePracticeGuideDesc2_Text", {
			desc = str,
			fontName = TTF_FONT_FZYH_M
		})
	end

	local label = ccui.RichText:createWithXML(str, {})

	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 0))
	label:renderContent()
	label:setVerticalSpace(-4)
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(cc.size(380, 0))
	label:renderContent()

	local offsetX = 4
	local height = label:getContentSize().height + 2

	panel:setContentSize(cc.size(width, height + 0))
	label:addTo(panel):posite(40 + offsetX, 0)
	self._listView:pushBackCustomItem(panel)

	local icon = cc.Sprite:createWithSpriteFrameName("rw_tishi_02.png")

	icon:addTo(panel):posite(24 + offsetX, height - 18)
end

function StagePracticeGuideTipMediator:onClickOkBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
