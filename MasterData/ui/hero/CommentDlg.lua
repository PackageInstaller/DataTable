-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\CommentDlg.lua

local UIControls = require("UI/UIControls")
local SDKConst = require("SDK/SDKConst")
local CommentMixin = require("Avatar/AvatarMixins/CommentMixin")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResRaiders = require("ClientData/ResRaiders")
local ResponseCode = SDKConst.ResponseCode
local COMMENT_SHOW_TYPE = {
	MOST_LIKES = Lang.get(30324),
	LATEST_COMMENT = Lang.get(30325),
	MY_COMMENT = Lang.get(30326)
}
local RAIDERS_OR_COMMENT = {
	RAIDERS = 11,
	COMMENT = 12
}
local COMMENT_ORDER_BY = {
	FAVOR = "-favor_num",
	CREATED = "-created"
}
local LIMIT_PAGE_COUNT = 20
local HeroSuitPanel = Class("HeroSuitPanel", UIControls.Panel)

function HeroSuitPanel:ctor()
	self:initUI()
end

function HeroSuitPanel:initUI()
	self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextName")
	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.txtDesBg = UIControls.Panel(self, self.mPath .. "/BgTextDes")
	self.txtDes = UIControls.Label(self, self.mPath .. "/BgTextDes/TextDes")
end

function HeroSuitPanel:onBtnSelfClick()
	self.txtDesBg:setVisible(true)
	self.mParent.suitSensor:setVisible(true)
end

function HeroSuitPanel:setData(suitId)
	local suitInfo = ResEquipSuit[suitId]

	if suitInfo then
		self.imgIcon:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.big_icon_path, suitInfo.big_icon)
		self.txtTitle:setText(suitInfo.name)
		self.txtDes:setText(suitInfo.des)
	end
end

local Guide = Class("Guide", UIControls.Child)

function Guide:ctor()
	self.heroInfoGroups = {}
	self.suits = {}
	self.artifacts = {}
	self.suitBtns = {}
	self.heroConfig = ResRaiders[self.mParent.heroId]
	self.overviewText = UIControls.Label(self, "BgPanel/GuideText/ScrollView/Viewport/Content/Text")
	self.showPanel = UIControls.Panel(self, "BgPanel")

	if self.heroConfig then
		self.showPanel:setVisible(true)
	else
		self.showPanel:setVisible(false)
	end

	self.noneGuidePanel = UIControls.Panel(self, "NoneGuidePanel")

	self.noneGuidePanel:setVisible(not self.heroConfig)

	self.guideText = UIControls.Label(self, "BgPanel/GuideText/ScrollView/Viewport/Content/Text")

	if self.heroConfig then
		self:initHeroGroup()
		self:initSuitPanel()
	end
end

function Guide:initHeroGroup()
	self.overviewText:setText(self.heroConfig and self.heroConfig.raiders)

	for key, value in pairs(self.heroConfig.recommendHeros) do
		self.heroInfoGroups[key] = UIControls.GridHeroInfoChild(self, "BgPanel/GuideHero/HeroInfoGroup", "System/Common/Grid/GridHeroInfo")

		self.heroInfoGroups[key]:setHero(BaseObject.GetObject(value))
		self.heroInfoGroups[key]:hideHeroLv()
		self.heroInfoGroups[key].btnHeroHead:clearEventClick()
		self.heroInfoGroups[key].btnHeroHead:addEventClick(Functor(self.onBtnGridHeroClick, self, value))
	end
end

function Guide:onBtnGridHeroClick(heroId)
	UIManager.getUI("heroTips"):showObj(self, BaseObject.GetObject(heroId))
end

function Guide:initSuitPanel()
	for i = 1, 3 do
		self.suits[i] = HeroSuitPanel(self, "BgPanel/GuideSuit/SuitPanel/Suit0" .. i)

		self.suits[i]:setVisible(false)
	end

	for i, v in ipairs(self.heroConfig.recommend) do
		self.suitBtns[i] = UIControls.Button(self, "BgPanel/GuideSuit/TabPanel/Btn" .. i, "Text")

		self.suitBtns[i]:setText(v.name)
		self.suitBtns[i]:setVisible(true)
		self.suitBtns[i]:addEventClick(Functor(self.onSuitBtnClick, self, self.suitBtns[i], v))

		if i == 1 then
			self:onSuitBtnClick(self.suitBtns[i], v)
		end
	end

	self.suitSensor = UIControls.Button(self, "BgPanel/GuideSuit/SuitPanel/UIClickThrough")

	self.suitSensor:addEventClick(self.onSuitSensorClick)
end

function Guide:onSuitSensorClick()
	for i, v in ipairs(self.suits) do
		self.suits[i].txtDesBg:setVisible(false)
	end

	self.suitSensor:setVisible(false)
end

function Guide:onSuitBtnClick(btn, info)
	if not self.onPressedBtn then
		self.onPressedBtn = btn
	else
		self.onPressedBtn:setEnable(true)
	end

	btn:setEnable(false)

	self.onPressedBtn = btn

	for _, v in ipairs(self.suits) do
		v:setVisible(false)
	end

	for i, v in ipairs(info.suit) do
		self.suits[i]:setData(v)
		self.suits[i]:setVisible(true)
	end

	for i, v in ipairs(self.artifacts) do
		if self.artifacts[i] then
			self.artifacts[i]:destroy()

			self.artifacts[i] = nil
		end
	end

	for i, v in ipairs(info.artifact) do
		self.artifacts[i] = UIControls.GridNameContainerChild(self, "BgPanel/GuideSuit/GridBadgePanel", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

		self.artifacts[i]:setObj(BaseObject.GetObject(v))
		self.artifacts[i]:setTextColor(0, 0, 0, 0)
	end
end

function Guide:onHide()
	self:setVisible(false)
end

function Guide:onShow()
	self:setVisible(true)
end

local BtnTypeCell = Class("BtnListTypeCell", UIControls.Child)

function BtnTypeCell:ctor()
	self.text = UIControls.Label(self, "Text")
	self.btnSort = UIControls.Button(self, "")

	self.btnSort:addEventClick(self.onBtnSortClick)
end

function BtnTypeCell:setCellInfo(text)
	self.text:setText(text)
end

function BtnTypeCell:onBtnSortClick()
	self.mParent:onBtnListTypeCellClick(self, self.text:getText())
end

local HeroEvaluateCell = Class("HeroEvaluateCell", UIControls.ScrollViewLoopCell)

function HeroEvaluateCell:ctor()
	self.like = nil
	self.playerName = UIControls.Label(self, "MessageInfo/TextPlayerName")
	self.playerComment = UIControls.Label(self, "MessageInfo/TextMessage")
	self.playerCommentDate = UIControls.Label(self, "MessageInfo/TextTime")
	self.praiseNum = UIControls.Label(self, "MessageInfo/TogglePraise/Bg/PraiseNub")
	self.praiseAni = UIControls.Panel(self, "MessageInfo/TogglePraise/Bg")
	self.btnPraised = UIControls.Button(self, "MessageInfo/TogglePraise")

	self.btnPraised:addEventClick(self.praiseComment)

	self.praiseStateImg = UIControls.Image(self, "MessageInfo/TogglePraise/Bg/ImgHand/ImgHand")
	self.btnMoreComment = UIControls.Button(self, "HeroEvaluateMoreBtn")

	self.btnMoreComment:addEventClick(self.moreComment)
end

function HeroEvaluateCell:setItemData(data, commentType, isLast)
	self.praiseNum:setColorByRGBA(1, 1, 1, 1)

	self.commentType = commentType
	self.commentId = data.id

	if RegionUtils.isJP() and string.find(data.name, "%$") then
		self.playerName:setText(Const.DEFAULT_NAME)
	else
		self.playerName:setText(data.name)
	end

	self.playerComment:setText(data.content)

	self.uid = data.uid

	self.playerCommentDate:setText(utils.getDeadlineStr(data.created))
	self.praiseNum:setText(data.favor_num)

	self.like = data.is_favor == 1 and true or false

	if data.is_favor == 1 then
		self.praiseAni:playStateAnimator("PraiseSel")
	else
		self.praiseAni:playStateAnimator("PraiseDis")
	end

	if isLast then
		self.btnMoreComment:setVisible(true)
	else
		self.btnMoreComment:setVisible(false)
	end

	self:setLayoutSize(nil, self.playerComment:getHeight() + (isLast and 118 or 70))

	if commentType == COMMENT_SHOW_TYPE.MY_COMMENT then
		self.btnPraised:setVisible(false)
	else
		self.btnPraised:setVisible(true)
	end
end

function HeroEvaluateCell:praiseComment(sender)
	if self.like then
		CurAvatar:FavorHandler(CurAvatar.uid, self.commentId, 1, Functor(self.praiseCommentCallback, self))
	else
		CurAvatar:FavorHandler(CurAvatar.uid, self.commentId, 0, Functor(self.praiseCommentCallback, self))
	end
end

function HeroEvaluateCell:praiseCommentCallback(responseCode)
	if responseCode == ResponseCode.SUCC then
		if not self.like then
			MsgManager.notice(Lang.get(30327))

			self.like = true

			self.praiseAni:playStateAnimator("PraiseDisToSel")
			self.praiseNum:setText(tonumber(self.praiseNum:getText()) + 1)
		else
			MsgManager.notice(Lang.get(30328))

			self.like = false

			self.praiseAni:playStateAnimator("PraiseSelToDis")
			self.praiseNum:setText(tonumber(self.praiseNum:getText()) - 1)
		end

		self.mParent:refreshComments(self)
	else
		MsgManager.notice(Lang.get(30329))
	end
end

function HeroEvaluateCell:moreComment()
	local orderby, commentId, page

	if self.commentType == COMMENT_SHOW_TYPE.MOST_LIKES then
		page = self.mParent.favorPage
		orderby = COMMENT_ORDER_BY.FAVOR
	elseif self.commentType == COMMENT_SHOW_TYPE.LATEST_COMMENT then
		commentId = self.mParent.newestStartId
		orderby = COMMENT_ORDER_BY.CREATED
	end

	self.mParent:requestComment(self.commentType, orderby, nil, page, nil, commentId)
end

local Evaluate = Class("Evaluate", UIControls.Child)

function Evaluate:ctor()
	self.btnListTypeCells = {}
	self.commentDataOrderByFavor = nil
	self.commentDataOrderByCreated = nil
	self.myComment = nil
	self.commentType = COMMENT_SHOW_TYPE.MOST_LIKES
	self.favorPage = 1
	self.score = UIControls.Label(self, "BgPanel/EvaluateNubText")
	self.btnScore = UIControls.Button(self, "BgPanel/BtnScore")

	self.btnScore:addEventClick(Functor(self.onBtnScoreClick, self, "score"))

	self.btnEvaluate = UIControls.Button(self, "BgPanel/BtnEvaluate")

	self.btnEvaluate:addEventClick(Functor(self.onBtnScoreClick, self, "evaluate"))

	if self.mParent.noComment then
		self.btnEvaluate:setVisible(false)
		self.btnScore:setVisible(false)
	end

	self.btnListType = UIControls.Button(self, "BgPanel/BtnListType", "Text")

	self.btnListType:addEventClick(self.onBtnListTypeClick)
	self.btnListType:setText(COMMENT_SHOW_TYPE.MOST_LIKES)

	self.ImgListType = UIControls.Image(self, "BgPanel/BtnListType")
	self.listTypePanel = UIControls.Panel(self, "BgPanel/ListTypePanel")

	self.listTypePanel:setVisible(false)

	self.btnCloseListType = UIControls.Button(self, "BgPanel/UIClickThrough")

	self.btnCloseListType:addEventClick(self.onBtnListTypeClick)
	self.btnCloseListType:setVisible(false)

	self.noneGuidePanel = UIControls.Panel(self, "BgPanel/NoneGuidePanel")

	self.noneGuidePanel:setVisible(true)

	self.commentMessage = UIControls.ScrollViewLoopV(self, "BgPanel/MessagePanel", 0, self.onCellChanged)

	self:init()
	CurAvatar:GetRateHandler(self.mParent.heroId, nil, Functor(self.setScoreText, self))
	self:requestComment(COMMENT_SHOW_TYPE.MOST_LIKES, COMMENT_ORDER_BY.FAVOR, nil, self.favorPage)
end

function Evaluate:init()
	self.btnListTypeCells[1] = BtnTypeCell(self, "BgPanel/ListTypePanel", "System/Hero/BtnListTypeCell")

	self.btnListTypeCells[1]:setCellInfo(COMMENT_SHOW_TYPE.MOST_LIKES)
	self.btnListTypeCells[1]:setVisible(true)

	self.btnListTypeCells[2] = BtnTypeCell(self, "BgPanel/ListTypePanel", "System/Hero/BtnListTypeCell")

	self.btnListTypeCells[2]:setCellInfo(COMMENT_SHOW_TYPE.LATEST_COMMENT)
	self.btnListTypeCells[2]:setVisible(true)

	self.btnListTypeCells[3] = BtnTypeCell(self, "BgPanel/ListTypePanel", "System/Hero/BtnListTypeCell")

	self.btnListTypeCells[3]:setCellInfo(COMMENT_SHOW_TYPE.MY_COMMENT)
	self.btnListTypeCells[3]:setVisible(true)
end

function Evaluate:requestComment(commentShowType, orderby, offset, page, created, commentId, myself)
	local uid

	if myself then
		uid = CurAvatar.uid
	end

	local entry_id = self.mParent.heroId
	local current_uid = CurAvatar.uid
	local callback = Functor(self.heroEvaluateItemCallback, self, commentShowType, orderby)

	CurAvatar:GetCommentHandler(entry_id, current_uid, LIMIT_PAGE_COUNT, offset, page, orderby, created, commentId, uid, callback)
end

function Evaluate:setScoreText()
	local rateData = CurAvatar:getRateData()
	local commentDlg = UIManager.tryGetUI("commentDlg")

	if rateData and rateData[self.mParent.heroId] and commentDlg and commentDlg == self.mWindow then
		if rateData[self.mParent.heroId].rate == 0 then
			self.score:setText("--")
		else
			self.score:setText(string.format("%.1f", rateData[self.mParent.heroId].rate))
		end

		self.rateScoreSum = tonumber(rateData[self.mParent.heroId].score_sum) or 0
		self.rateCount = tonumber(rateData[self.mParent.heroId].rate_count) or 0
	end
end

function Evaluate:heroEvaluateItemCallback(commentShowType, orderby, responseCode)
	local commentDlg = UIManager.tryGetUI("commentDlg")

	if responseCode == ResponseCode.SUCC and commentDlg and commentDlg == self.mWindow then
		local allData = CurAvatar:getAllCommentData()

		if allData then
			self:orderCommentData(orderby, allData.data)
			self:updateCommentItems(commentShowType)

			if commentShowType ~= COMMENT_SHOW_TYPE.MY_COMMENT then
				self.totalCommentCount = allData.count
			end
		end
	end
end

function Evaluate:orderCommentData(orderby, allData)
	if not allData[#allData] then
		local heroEvaluateDlg = UIManager.tryGetUI("heroEvaluateDlg")

		if heroEvaluateDlg then
			heroEvaluateDlg:hideEvaluateNotice()
		end

		return
	end

	self.noneGuidePanel:setVisible(false)

	if orderby == COMMENT_ORDER_BY.FAVOR then
		self.favorPage = self.favorPage + 1

		if not self.commentDataOrderByFavor then
			self.commentDataOrderByFavor = {}
		end

		for _, v in ipairs(allData) do
			table.insert(self.commentDataOrderByFavor, v)
		end
	elseif orderby == COMMENT_ORDER_BY.CREATED then
		self.newestStartId = allData[#allData] and allData[#allData].id

		if not self.commentDataOrderByCreated then
			self.commentDataOrderByCreated = {}
		end

		for _, v in ipairs(allData) do
			table.insert(self.commentDataOrderByCreated, v)
		end
	else
		self.myComment = allData

		CurAvatar:setMyComment(self.mParent.heroId, allData)
	end
end

function Evaluate:updateCommentItems(ShowType, jumpIdx)
	if ShowType == COMMENT_SHOW_TYPE.MOST_LIKES then
		self.commentData = self.commentDataOrderByFavor

		if self.commentDataOrderByFavor then
			self.commentMessage:setTotalCount(#self.commentDataOrderByFavor, jumpIdx)
		else
			self.commentMessage:setTotalCount(0, 1)
		end
	elseif ShowType == COMMENT_SHOW_TYPE.LATEST_COMMENT then
		self.commentData = self.commentDataOrderByCreated

		if self.commentDataOrderByCreated then
			self.commentMessage:setTotalCount(#self.commentDataOrderByCreated, jumpIdx)
		else
			self.commentMessage:setTotalCount(0, 1)
		end
	elseif ShowType == COMMENT_SHOW_TYPE.MY_COMMENT then
		self.commentData = self.myComment

		if self.myComment then
			self.commentMessage:setTotalCount(#self.myComment, jumpIdx)
		else
			self.commentMessage:setTotalCount(0)
		end
	end
end

function Evaluate:onCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = HeroEvaluateCell(sender, "System/Hero/HeroEvaluateCell", newIdx)
	end

	if newIdx % LIMIT_PAGE_COUNT == 0 and newIdx == #self.commentData then
		targetCell:setItemData(self.commentData[newIdx], self.commentType, self.totalCommentCount ~= newIdx)
	else
		targetCell:setItemData(self.commentData[newIdx], self.commentType)
	end
end

function Evaluate:onBtnScoreClick(panelType)
	if not CurAvatar.uid or CurAvatar.name == "" then
		MsgManager.notice(Lang.get(30330))

		return
	end

	local heroEvaluateDlg = UIManager.getUI("heroEvaluateDlg", true)

	heroEvaluateDlg:switchPanel(panelType, self.mParent.heroId, self)

	if panelType == "evaluate" then
		self.myComment = CurAvatar:getMyComment(self.mParent.heroId)

		if not self.myComment then
			self:requestComment(nil, nil, nil, nil, nil, nil, true)
		end
	elseif panelType == "score" then
		CurAvatar:GetMyRateHandler(self.mParent.heroId, CurAvatar.uid, Functor(self.scoreCallback, self))
	end
end

function Evaluate:checkComment()
	for i, v in pairs(CurAvatar.heroDic) do
		if v.id == self.mParent.heroId then
			return false
		end
	end

	return true
end

function Evaluate:scoreCallback(responseCode)
	if responseCode == ResponseCode.SUCC then
		local maRate = CurAvatar:getMyRate()

		if maRate.score == 0 then
			local heroEvaluateDlg = UIManager.tryGetUI("heroEvaluateDlg")

			if heroEvaluateDlg then
				heroEvaluateDlg:hideScoreNotice()
			end
		end
	end
end

function Evaluate:onBtnListTypeClick()
	if not self.listTypePanel:getVisible() then
		self.listTypePanel:setVisible(true)
		self.btnCloseListType:setVisible(true)
		self.ImgListType:setImage("Atlas/HeroAtlas/HeroEvaluateAtlas", "BgDropUp")
	else
		self.listTypePanel:setVisible(false)
		self.btnCloseListType:setVisible(false)
		self.ImgListType:setImage("Atlas/HeroAtlas/HeroEvaluateAtlas", "BgDropDown")
	end
end

function Evaluate:onBtnListTypeCellClick(sender, text, isCallback)
	if not isCallback then
		self:onBtnListTypeClick()
	end

	self.curListType = text

	self.btnListType:setText(text)

	self.commentType = text

	if text == COMMENT_SHOW_TYPE.MOST_LIKES then
		if not self.commentDataOrderByFavor then
			self:requestComment(COMMENT_SHOW_TYPE.MOST_LIKES, COMMENT_ORDER_BY.FAVOR, nil, self.favorPage)
		else
			self:updateCommentItems(COMMENT_SHOW_TYPE.MOST_LIKES, 1)
		end
	elseif text == COMMENT_SHOW_TYPE.LATEST_COMMENT then
		if not self.commentDataOrderByCreated or not self.newestStartId then
			self:requestComment(COMMENT_SHOW_TYPE.LATEST_COMMENT, COMMENT_ORDER_BY.CREATED)
		else
			self:updateCommentItems(COMMENT_SHOW_TYPE.LATEST_COMMENT, 1)
		end
	elseif text == COMMENT_SHOW_TYPE.MY_COMMENT then
		self.myComment = CurAvatar:getMyComment(self.mParent.heroId)

		if not self.myComment then
			self:requestComment(COMMENT_SHOW_TYPE.MY_COMMENT, nil, nil, nil, nil, nil, true)
		else
			self:updateCommentItems(COMMENT_SHOW_TYPE.MY_COMMENT, 1)
		end
	end
end

function Evaluate:newCommentCallback(content)
	self.favorPage = 1
	self.commentDataOrderByFavor = nil

	if content then
		local newCom = {}

		newCom[1] = {}
		newCom[1].content = content
		newCom[1].name = CurAvatar.name
		newCom[1].favor_num = 0
		newCom[1].created = os.time()
		newCom[1].updated = os.time()
		newCom[1].uid = CurAvatar.uid

		CurAvatar:setMyComment(self.mParent.heroId, newCom)

		if self.commentDataOrderByCreated then
			for k, v in ipairs(self.commentDataOrderByCreated) do
				if v.name == CurAvatar.name then
					table.remove(self.commentDataOrderByCreated, k)
				end
			end

			table.insert(self.commentDataOrderByCreated, 1, newCom[1])
		end
	end

	self:onBtnListTypeCellClick(nil, self.commentType, true)
end

function Evaluate:refreshScoreText(score)
	if self.rateCount == 0 then
		self.score:setText(string.format("%.1f", score))
	end
end

function Evaluate:refreshComments(heroEvaluateCell)
	if self.commentDataOrderByFavor then
		for _, v in ipairs(self.commentDataOrderByFavor) do
			if heroEvaluateCell.uid == v.uid then
				v.is_favor = heroEvaluateCell.like and 1 or 0
				v.favor_num = heroEvaluateCell.like and v.favor_num + 1 or v.favor_num - 1
			end
		end
	end

	if self.commentDataOrderByCreated then
		for _, v in ipairs(self.commentDataOrderByCreated) do
			if heroEvaluateCell.uid == v.uid then
				v.is_favor = heroEvaluateCell.like and 1 or 0
				v.favor_num = heroEvaluateCell.like and v.favor_num + 1 or v.favor_num - 1
			end
		end
	end

	self.myComment = CurAvatar:getMyComment(self.mParent.heroId)

	if self.myComment then
		if heroEvaluateCell.uid == self.myComment[1].uid then
			self.myComment[1].is_favor = heroEvaluateCell.like and 1 or 0
			self.myComment[1].favor_num = heroEvaluateCell.like and self.myComment[1].favor_num + 1 or self.myComment[1].favor_num - 1
		end

		CurAvatar:setMyComment(self.mParent.heroId, self.myComment)
	end
end

function Evaluate:onHide()
	self:setVisible(false)
end

function Evaluate:onShow()
	self:setVisible(true)
end

local strClassName = "CommentDlg"
local CommentDlg = Class(strClassName, UIControls.Window)

function CommentDlg:ctor()
	self.curChooseType = nil
	self.onDlgClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.onDlgClose:addEventClick(self.btnClose)

	self.rolePortrait = UIControls.Role(self, "BgPanel/PanelTabContent/Content/HeroPortraitPanel/GridHeroPortrait", 0, 0)
	self.btnGuide = UIControls.Button(self, "BgPanel/TabPanel/BtnGuide")

	self.btnGuide:addEventClick(Functor(self.onBtnGuideEvaluateClick, self, RAIDERS_OR_COMMENT.RAIDERS))

	self.btnEvaluate = UIControls.Button(self, "BgPanel/TabPanel/BtnEvaluate")

	self.btnEvaluate:addEventClick(Functor(self.onBtnGuideEvaluateClick, self, RAIDERS_OR_COMMENT.COMMENT))

	self.title = UIControls.Label(self, "BgPanel/TextTitle")
	self.panel = UIControls.Panel(self, "BgPanel/TabPanel")
end

function CommentDlg:setHeroId(id, NoComments)
	self.noComment = NoComments
	self.heroId = id

	if id then
		self.rolePortrait:showRole(id, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)
	end

	self:onBtnGuideEvaluateClick(RAIDERS_OR_COMMENT.RAIDERS)
end

function CommentDlg:onBtnGuideEvaluateClick(btnType)
	if btnType == RAIDERS_OR_COMMENT.RAIDERS then
		self.title:setText(Lang.get(30331))

		if not self.btnG then
			self.btnG = Guide(self, "BgPanel/PanelTabContent/Content", "System/Hero/HeroGuidePanel", 0, 0, true)
		else
			self.btnG:onShow()
		end

		if self.btnE then
			self.btnE:onHide()
		end
	elseif btnType == RAIDERS_OR_COMMENT.COMMENT then
		self.title:setText(Lang.get(1193))

		if not self.btnE then
			self.btnE = Evaluate(self, "BgPanel/PanelTabContent/Content", "System/Hero/HeroEvaluatePanel", 0, 0, true)
		else
			self.btnE:onShow()
		end

		if self.btnG then
			self.btnG:onHide()
		end
	end

	self.btnGuide:setEnable(btnType ~= RAIDERS_OR_COMMENT.RAIDERS)
	self.btnEvaluate:setEnable(btnType ~= RAIDERS_OR_COMMENT.COMMENT)
end

function CommentDlg:btnClose()
	self:setVisible(false)
end

return CommentDlg
