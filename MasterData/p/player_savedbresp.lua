
local Player = require "Player"
local GameGlobal
if GV.IsServer then
	GameGlobal = require "GameGlobal"
end 

----------------------------------------------------------------------------------------
--获取参数
----------------------------------------------------------------------------------------
--获取支付道具下发待保存订单列表
--@param {table} user
--@return {table} list
local function getFinishOrderList(user)
	local list = {}
	local tab = user:getFinishPayOrderData()
	for trade_no, _ in pairs(tab) do
		table.insert(list, trade_no)
	end
	return list
end

--获取兑换码Gift状态待保存列表
--@param {table} user
--@return {table} list
local function getRedeemCodeGiftList(user)
	local list = {}
	for code, gifts in pairs(user.redeemCode) do
		for id, gift in pairs(gifts) do
			if gift.status == GE.redeemCodeGetStatus.get_reward then
				table.insert(list, {code = code, giftId = id})
			end
		end
	end
	return list
end

--获取微信通知奖励下发待保存的订单id列表
--@param {table} user
--@return {table} list
local function getWechatNtfOrderList(user)
	local recordData = user:GetWechatNtfRewardData()
	local list = {}
	for k, _ in pairs(recordData) do
		table.insert(list, k)
	end
	return list
end


----------------------------------------------------------------------------------------
--保存返回函数
----------------------------------------------------------------------------------------
--基础数据
local function userDataCall(user, orderList)
	--LuaLogger.ds("------------userDataCall", tablex.dump(orderList))
	local finishPay = user:getFinishPayOrderData()
	for k, v in pairs(orderList) do
		if finishPay[v] then
			local ok, reason = GameGlobal.Pay_ServerCheck(user.uid, finishPay[v])
			if ok or reason == ActionFailReason.PayOrderHaveDone then
				finishPay[v] = nil
			end
		end
	end

end

--保存兑换码返回
local function redeemCodeCall(user, codeList)
	--LuaLogger.ds("------------redeemCodeCall", tablex.dump(codeList))
	for k, v in pairs(codeList) do
		user:confirmRedeemCodeReward(v.code, v.giftId)
	end

end

--保存微信数据返回
local function wechatDataCall(user, orderList)
	--LuaLogger.ds("------------wechatDataCall", tablex.dump(orderList))
	for _, orderId in pairs(orderList) do
		user:confirmWechatMsgState(orderId)
	end

end

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--保存字段配置
--respCall 保存完成后，返回回调函数
--respParam 保存完成后，携带参数(没有此参数，保存完成后不需要返回)
local saveDBRerspCfg = 
{
	["userData"] = {respCall = userDataCall, respParam = getFinishOrderList},
	["redeemCode"] = {respCall = redeemCodeCall, respParam = getRedeemCodeGiftList},
	-- ["wechatData"] = {respCall = wechatDataCall, respParam = getWechatNtfOrderList},

}

--saveDB成功是否需要返回
function Player:userToDBIsResp(saveData)
	if not GV.IsServer then
		return nil
	end

	local resp = {}
	for key, _ in pairs(saveData) do
		local tb = saveDBRerspCfg[key]
		if tb and tb.respParam then
			local param
			if type(tb.respParam) == "function" then
				param = tb.respParam(self)
			else
				param = tb.respParam
			end
			
			table.insert(resp, {key = key, param = param})
		end
	end

	if next(resp) then
		return resp
	end
	return nil
end

--saveDB成功返回
function Player:userSaveDBResp(data)
	if not GV.IsServer then
		return
	end

	for _, v in pairs(data) do
		local tb = saveDBRerspCfg[v.key]
		if tb and tb.respCall then
			tb.respCall(self, v.param)
			self:save(true)
		end
	end
end


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--获取保存变化的数据
--return {table} saveData
function Player:getSaveDBData()
	local saveDb = {}
	for k,v in pairs(self.dirtyValues) do
		local data = self[k]
		--LuaLogger.ds("dirtyValues ", k, tablex.dump(v))
		if GV.IsServer and Player.allowPartSave(k) and next(v) and data then
			local part = {}
			for k1, _ in pairs(v) do
				part[k1] = (data[k1] ~= nil) and data[k1] or "__null__"
			end
			saveDb[k] = part
			--LuaLogger.ds("getSaveDBData ", k, tablex.dump(part))
		else
			saveDb[k] = data
		end
    end
    return saveDb
end

--拷贝保存变化数据
--param {table} saveData
--					name => data
--							k => v
--param {table} toData
--param {boolean} dirty 记录tag
function Player:copySaveData(saveData, toData, dirty)
	for k, v in pairs(saveData) do
		if GV.IsServer and Player.allowPartSave(k) then
			local part = toData[k] or {}
			for k1, v1 in pairs(v) do
				if dirty then
					--保存tag
					if v1 == "__null__" then
						part[k1] = v1
					else
						part[k1] = "@user"
					end
				else
					--保存数据
					if v1 == "__null__" then
						part[k1] = nil
					else
						part[k1] = v1
					end
				end
			end

			if part and next(part) then
				toData[k] = part
			end

		else
			if dirty then
				--保存tag
				toData[k] = "@user"
			else
				--保存数据
				toData[k] = v
			end
		end
		--LuaLogger.ds("copySaveData ", k)
	end
end

--获取变化的dirty玩家数据
--param {table} user {dirtyData}
--param {table} dirtyData
function Player:getDirtySaveData(user)
	if not user or not user.dirtyData then
		return
	end

	local dirtyData = {}
	for k, v in pairs(user.dirtyData) do
		if GV.IsServer and Player.allowPartSave(k) then
			local part = user[k] or {}
			for k1, v1 in pairs(v) do
				--保存数据
				if v1 == "@user" then
					v[k1] = part[k1]
				end
			end

			if v and next(v) then
				dirtyData[k] = v
			end

		else
			if v == "@user" then
				dirtyData[k] = user[k]
			else
				dirtyData[k] = v
			end
		end
	end

	return dirtyData
end

--合并保存数据
function Player:mergeWaitSaveData(dest, saveData)
	for k, v in pairs(saveData) do
		if GV.IsServer and Player.allowPartSave(k) and next(v) then
			local part = dest[k] or {}
			for k1, v1 in pairs(v) do
				part[k1] = v1
			end
			dest[k] = part
		else
			dest[k] = v
		end
	end
end

return Player