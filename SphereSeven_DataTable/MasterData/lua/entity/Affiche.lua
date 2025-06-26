--[[
-- added by wsh @ 2017-12-05
-- 玩家实体
--]]

local Affiche = BaseClass("Affiche",Entity)
local base = Entity

local function Awake(self,AfficheInfo)
	base.Awake(self)
	--Title  标题
	--Subtitle 副标题
	--Content   内容
	--Date   日期
	
	self.Title = AfficheInfo.Title
	self.Subtitle = AfficheInfo.Subtitle
	self.Content = AfficheInfo.Content
	self.Date = AfficheInfo.Date
	self.ImgUrl = AfficheInfo.ImgUrl
	self.Id = AfficheInfo.Id 
	self.Index = AfficheInfo.Index
	self.RedPoint = AfficheInfo.RedPoint
end

local function Dispose(self)
	base.Dispose(self)
end

Affiche.Awake = Awake
Affiche.Dispose = Dispose
return Affiche