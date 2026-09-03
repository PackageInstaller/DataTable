-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameRankCell.lua

MiniGameRankCell = class("MiniGameRankCell", BaseWidget, _M)

MiniGameRankCell:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function MiniGameRankCell:initialize(resFile, node)
	if not node then
		::label_1_0::

		local node = cc.CSLoader:createNode(resFile)

		super.initialize(self, node)
	end
end

function MiniGameRankCell:createView()
	self._main = self._view:getChildByName("main")
end

function MiniGameRankCell:getView()
	return self._view
end

function MiniGameRankCell:refreshView(record, isSelf)
	local rankLabel = self._main:getChildByName("ranklabel")

	MiniGameRankCell:createRankImg(self._main, rankLabel, record)
	self:createPartView1(record, isSelf)
	self:createPartView2(record)
end

local RankTopBgImage = {
	"img_dwtx_ph_1.png",
	"img_dwtx_ph_2.png",
	"img_dwtx_ph_3.png"
}

function MiniGameRankCell.class:createRankImg(cell, rankLabel, record, ignoreBg)
	local rankImgTag = 234
	local rankNode = rankLabel
	local oldRankImg = cell:getChildByTag(rankImgTag)

	if oldRankImg then
		oldRankImg:removeFromParent(false)
	end

	local rank = record:getRank()
	local posX, posY = rankLabel:getPosition()

	rankLabel:setVisible(rank > 3)
	rankLabel:setScale(1)

	local bg = cell:getChildByFullName("bg_normal")

	if rank <= 3 then
		local img = cc.Sprite:createWithSpriteFrameName(RankTopImage[rank])

		img:addTo(cell, 1, rankImgTag):posite(posX, posY)

		rankNode = img

		if not ignoreBg then
			bg:loadTexture(RankTopBgImage[rank], 1)
		end
	else
		if not ignoreBg then
			bg:loadTexture("img_dwtx_ph_4.png", 1)
		end

		rankLabel:setString(rank)
	end

	return rankNode
end

function MiniGameRankCell:createPartView1(record, isSelf)
	local parent = self._main:getChildByFullName("iconnode")

	parent:removeAllChildren(true)

	local headInfo = {
		clipType = 4,
		id = record:getHeadId(),
		headFrameId = record:getHeadFrame(),
		size = cc.size(93, 94)
	}
	local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

	headIcon:addTo(parent):center(parent:getContentSize()):offset(2, -2)
	headIcon:setScale(0.6)
	oldIcon:setScale(0.5)

	if isSelf then
		-- block empty
	end

	local nameLabel = self._main:getChildByFullName("namelabel")
	local nameText

	nameLabel:setString(record:getName())
end

function MiniGameRankCell:createPartView2(record)
	local scoreLabel = self._main:getChildByFullName("scorelabel")

	scoreLabel:setString(record:getScore())

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(221, 191, 143, 255)
		}
	}

	scoreLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
end
