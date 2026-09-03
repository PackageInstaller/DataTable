-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/view/component/BaseRankCell.lua

BaseRankCell = class("BaseRankCell", DisposableObject, _M)

function BaseRankCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/RankCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setProperty()
	self:setupView()
end

function BaseRankCell:dispose()
	super.dispose()
end

function BaseRankCell:getView()
	return self._view
end

function BaseRankCell:setProperty()
	return
end

function BaseRankCell:setupView()
	self:initWigetInfo()
end

function BaseRankCell:initWigetInfo()
	self._cellBg = self:getView():getChildByName("cell_bg")
	self._textRank = self._cellBg:getChildByName("text_rank")
	self._bgImage = self._cellBg:getChildByName("bgImage")
	self._textName = self._cellBg:getChildByName("name")
	self._text3 = self._cellBg:getChildByName("text_3")
	self._text4 = self._cellBg:getChildByName("text_4")
	self._imgMyself = self._cellBg:getChildByName("img_myself")
	self._rankRemain = self._cellBg:getChildByName("rankRemain")
	self._rankChange = self._cellBg:getChildByName("rankChange")
	self._emptyImg = self._cellBg:getChildByName("empty_img")

	self._textRank:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._textName:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._text3:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._text4:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._imgMyself:getChildByName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._rankChange:getChildByName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._rankRemain:getChildByName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(0, 0, 0, 255)
		}
	}

	self._rankRemain:getChildByName("text1"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function BaseRankCell:refreshData(record)
	local rank = record:getRank()

	self._emptyImg:setVisible(false)
	self._textRank:setVisible(true)
	self._textRank:setString(tostring(rank))

	local bg = rank % 2 == 0 and "bd_bg_xxt_2.png" or "bd_bg_xxt_1.png"

	self._bgImage:loadTexture(bg, 1)
	self._imgMyself:setVisible(record:getRid() == self._mediator:getDevelopSystem():getRid())
	self._rankRemain:setVisible(false)
	self._rankChange:setVisible(false)

	if rank == 1 and record:getRetains() ~= 0 then
		self._rankRemain:setVisible(true)
		self._rankRemain:getChildByName("text"):setString(Strings:get("RANK_UI12", {
			day = math.ceil(record:getRetains())
		}))
	elseif record:getChange() ~= 0 then
		self._rankChange:setVisible(true)

		local text = self._rankChange:getChildByName("text")

		text:setString(math.abs(math.ceil(record:getChange())))
	end

	if record:getChange() > 0 then
		self._rankChange:getChildByName("type"):loadTexture("asset/common/common_icon_jt_1.png")
		self._rankChange:getChildByName("text"):setTextColor(cc.c3b(181, 235, 19))
	elseif record:getChange() < 0 then
		self._rankChange:getChildByName("type"):loadTexture("asset/common/common_icon_jt_2.png")
		self._rankChange:getChildByName("text"):setTextColor(cc.c3b(255, 77, 7))
	end

	if self._cellBg:getChildByName("title") then
		self._cellBg:removeChildByName("title")
	end

	if record:getTitle() ~= "" then
		local icon = IconFactory:createTitleIcon({
			id = record:getTitle()
		})

		icon:addTo(self._cellBg):posite(self._textRank:getPositionX() + 80, self._textRank:getPositionY() + 5)
		icon:setName("title")
		icon:setScale(0.58)
	end
end

function BaseRankCell:refreshEmpty(index)
	local rank = index
	local bg = rank % 2 == 0 and "bd_bg_xxt_2.png" or "bd_bg_xxt_1.png"

	self._bgImage:loadTexture(bg, 1)
	self._textRank:setVisible(true)
	self._textRank:setString(tostring(rank))
	self._emptyImg:setVisible(true)
	self._imgMyself:setVisible(false)
	self._rankRemain:setVisible(false)
	self._rankChange:setVisible(false)
	self._textName:setString("")
	self._text3:setString("")
	self._text4:setString("")

	if self._cellBg:getChildByName("title") then
		self._cellBg:removeChildByName("title")
	end
end

BlockRankCell = class("BlockRankCell", BaseRankCell, _M)

function BlockRankCell:initialize(info)
	super.initialize(self, info)
end

function BlockRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
	self._text4:setString(record:getStar())
end

CombatRankCell = class("CombatRankCell", BaseRankCell, _M)

function CombatRankCell:initialize(info)
	super.initialize(self, info)
end

function CombatRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
	self._text4:setString(record:getMaxCombat())
end

PetRaceRankCell = class("PetRaceRankCell", BaseRankCell, _M)

function PetRaceRankCell:initialize(info)
	super.initialize(self, info)
end

function PetRaceRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text4:setString(record:getScore())
	self._text3:setString(record:getWinNum())
end

CollectionRankCell = class("CollectionRankCell", BaseRankCell, _M)

function CollectionRankCell:initialize(info)
	super.initialize(self, info)
end

function CollectionRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text4:setString(record:getScore())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
end

ClubRankCell = class("ClubRankCell", BaseRankCell, _M)

function ClubRankCell:initialize(info)
	super.initialize(self, info)
end

function ClubRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getClubName())
	self._text3:setString(record:getPresidentName())
	self._text4:setString(record:getComatValue())
end

ClubBossRankCell = class("ClubBossRankCell", BaseRankCell, _M)

function ClubBossRankCell:initialize(info)
	super.initialize(self, info)
end

function ClubBossRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getClubName())
	self._text3:setString(record:getPresidentName())
	self._text4:setString(record:getComatValue())
end

MapRankCell = class("MapRankCell", BaseRankCell, _M)

function MapRankCell:initialize(info)
	super.initialize(self, info)
end

function MapRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
	self._text4:setString(record:getDp())
end

MazeRankCell = class("MazeRankCell", BaseRankCell, _M)

function MazeRankCell:initialize(info)
	super.initialize(self, info)
end

function MazeRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text4:setString(record:getDp())
end

ArenaRankCell = class("ArenaRankCell", BaseRankCell, _M)

function ArenaRankCell:initialize(info)
	super.initialize(self, info)
end

function ArenaRankCell:refreshData(record)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
	self._text4:setString(record:getScore())
end

CrusadeRankCell = class("CrusadeRankCell", BaseRankCell, _M)

function CrusadeRankCell:initialize(info)
	super.initialize(self, info)
end

function CrusadeRankCell:refreshData(record, pointData)
	super.refreshData(self, record)
	self._textName:setString(record:getName())
	self._text3:setString(record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName())
	self._text4:setString(pointData.name)
	GameStyle:setQualityText(self._text4, pointData.quality, true)
end
