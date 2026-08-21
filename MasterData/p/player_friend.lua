-- Desc: 社交数据处理
---@class Player
local Player = require "Player"
local GameGlobal
if GV.IsServer then
    GameGlobal = require "GameGlobal"
end


--------------------------------------------------------------------------------
--获得舰娘数量
function Player:getHeroNum()
	local num = tablex.size(self.heroList) or 0
	return num
end

--------------------------------------------------------------------------------
--更新昵称
---@param name string
function Player:socialUpdateUserName(name)
	local socialInfo = self:getSocialInfo()

    if name ~= socialInfo.baseInfo.name then
        socialInfo.baseInfo.name = name
        socialInfo.is_update = true
    end
end

--更新个性签名
---@param userSign string
function Player:socialUpdateUserSign(userSign)
	local socialInfo = self:getSocialInfo()
	if userSign ~= socialInfo.baseInfo.userSign then
		socialInfo.baseInfo.userSign = userSign
		socialInfo.is_update = true
	end
end

--更新等级
---@param level integer
function Player:socialUpdateLevel(level)
	local socialInfo = self:getSocialInfo()
	if level ~= socialInfo.baseInfo.level then
		socialInfo.baseInfo.level = level
		socialInfo.is_update = true
	end
end

--更新头像
---@param head integer
function Player:socialUpdateHead(head)
	local socialInfo = self:getSocialInfo()
	if head ~= socialInfo.baseInfo.head then
		socialInfo.baseInfo.head = head
		socialInfo.is_update = true
	end
end

--更新主线进度
---@param currLevelId integer
function Player:socialUpdateCurrLevelId(currLevelId)
	local socialInfo = self:getSocialInfo()

	if currLevelId ~= socialInfo.baseInfo.currLevelId then
		socialInfo.baseInfo.currLevelId = currLevelId
		socialInfo.is_update = true
	end
end

--更新英雄数量
function Player:socialUpdateHeroNum()
	local heroNum = self:getHeroNum()
	local socialInfo = self:getSocialInfo()
	if heroNum ~= socialInfo.baseInfo.heroNum then
		socialInfo.baseInfo.heroNum = heroNum
		socialInfo.is_update = true
	end
end


--更新社交数据
function Player:updateSocialInfo()
    if not GameGlobal then
        return
    end

	local socialInfo = self:getSocialInfo()

    --未变动
    if not socialInfo.is_update then
        return
    end

    GameGlobal.UpdateSocialInfo({
        uid = self.uid,
        baseInfo = socialInfo.baseInfo,
    })

    socialInfo.is_update = false
end

--获得社交数据
function Player:getSocialInfo()
	if not self.socialInfo then
		self:initSocialInfo()
	end
	return self.socialInfo
end

--初始化社交数据
function Player:initSocialInfo(isNew)
	local userData = self:getUserData()

	--封装属性
	self.socialInfo = {
		baseInfo = {
			uid = self.uid,
			name = self.name,
			head = self.head,
			level = self.level,
			currLevelId = userData.LevelMainMax or 0,
			heroNum = self:getHeroNum(),
			userSign = userData.UserSign or "",
			regDate = self.borntime or 0,
			loginDay = userData.LoginDay or 0,
			-- birthday 功能暂无
		}
	}

	--新玩家--isNew,先特殊处理
	if false then
		self.socialInfo.is_update = true
		self:updateSocialInfo()
	end
end




----------------------------------------client----------------------------------------
---获得好友数量
---@return integer
function Player:GetFriendCount()
	if self.friends == nil then
		return 0
	end
	return tablex.size(self.friends)
end

---获得自己友情点数量
---@return integer
function Player:GetFriendPointCount()
	if self.friends == nil then
		return 0
	end

	local count = 0
	for i,v in pairs(self.friendPointGet) do
		if v == true then
			count = count + 1
		end
	end
	return count
end


local maxFriendCount = nil
---获取好友最大数量 client
---@return integer
function Player:GetMaxFriendCount()
    if maxFriendCount ~= nil then
       return maxFriendCount 
    end
    maxFriendCount = Config.GetConfigInfo("FriendMaxCount")
    return maxFriendCount
end

local maxPointCount = nil
---获取最大友情点数量 client
---@return integer
function Player:GetMaxPointCount()
    if maxPointCount ~= nil then
       return maxPointCount 
    end
    maxPointCount = Config.GetConfigInfo("FriendPointMax")
    return maxPointCount
end


local pointCount = nil
---赠送一个好友获取的友情点数量
---@return integer
function Player:GetSendFriendAddpointCount()
    if pointCount ~= nil then
       return pointCount 
    end
    local tab = Config.GetConfigInfo("SendFriendAddpointCount")
	pointCount = tab[3]
    return pointCount
end

---获取可可领取好友点数
function Player:GetReceivableFriendPoints()
	if self.friends == nil then
		return 0
	end

    local curCount = self:GetFriendPointCount() 
    local maxCount =  self:GetMaxPointCount()
	if curCount >= maxCount then
		return 0
	end

	local count = 0
	for k, v in pairs(self.friends) do
		local isCanGet = self.friendPointGet[v.uid] == false
		if isCanGet then
			count = count + 1
		end
	end
	return count
end


return Player