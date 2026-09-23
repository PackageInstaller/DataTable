DormProto = {}

-- 宿舍更新
function DormProto:Update(proto)
    for i, v in ipairs(proto.infos) do
        DormMgr:UpdateData(v)
    end
    EventMgr.Dispatch(EventType.Dorm_Update)
end

-- 获取开放列表
function DormProto:GetOpenDorm(_fid, _cb)
    self.GetOpenDormCB = _cb
    local proto = {"DormProto:GetOpenDorm", {
        fid = _fid
    }}
    NetMgr.net:Send(proto)
end

function DormProto:GetOpenDormRet(proto)
    DormMgr:GetOpenDormRet(proto)
    if (self.GetOpenDormCB) then
        self.GetOpenDormCB()
    end
    self.GetOpenDormCB = nil
end

-- 获取单间宿舍信息
function DormProto:GetDorm(_fid, _id, _cb)
    self.GetDormCB = _cb
    local proto = {"DormProto:GetDorm", {
        fid = _fid,
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function DormProto:GetDormRet(proto)
    DormMgr:GetDormRet(proto)
    if (self.GetDormCB) then
        self.GetDormCB()
    end
    self.GetDormCB = nil
end

-- 宿舍升级 （返回宿舍更新） 
function DormProto:Upgrade(_id, _furnitures)
    local proto = {"DormProto:Upgrade", {
        id = _id,
        furnitures = _furnitures
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UpgradeRet(proto)
    -- 升级成功
    -- EventMgr.Dispatch(EventType.Dorm_Screenshot, DormMgr:GetScreenshotFileName(proto.id)) --rui 取消了分享暂屏蔽
end

-- 使用礼物（返回角色更新）  
function DormProto:UseGift(_roleId, _items)
    local proto = {"DormProto:UseGift", {
        roleId = _roleId,
        items = _items
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UseGiftRet(proto)
    EventMgr.Dispatch(EventType.Dorm_UseGiftRet, proto)
end

-- 改变家具（返回宿舍更新）
function DormProto:ModFurniture(_id, _furnitures, _img)
    local proto = {"DormProto:ModFurniture", {
        id = _id,
        furnitures = _furnitures,
        img = _img
    }}
    NetMgr.net:Send(proto)
end
function DormProto:ModFurnitureRet(proto)
    -- EventMgr.Dispatch(EventType.Dorm_Screenshot, DormMgr:GetScreenshotFileName(proto.id)) --rui 取消了分享暂屏蔽
end

-- 获取自己的主题
function DormProto:GetSelfTheme(_themeType, _GetSelfThemeCB)
    DormMgr:RemoveTheme(_themeType) --先移除，否则多次返回会出现叠加
    self.GetSelfThemeCB = _GetSelfThemeCB
    local proto = {"DormProto:GetSelfTheme", {
        themeTypes = _themeType
    }}
    NetMgr.net:Send(proto)
end
function DormProto:GetSelfThemeRet(proto)
    DormMgr:GetSelfThemeRet(proto)
    if (proto.isFinish) then
        if (self.GetSelfThemeCB) then
            self.GetSelfThemeCB()
        end
        self.GetSelfThemeCB = nil
    end
end

-- 获取排行榜的主题 
function DormProto:GetWroldTheme(_ix, _len, _byType)
    local proto = {"DormProto:GetWroldTheme", {
        ix = _ix,
        len = _len,
        byType = _byType
    }}
    NetMgr.net:Send(proto)
end
function DormProto:GetWroldThemeRet(proto)
    EventMgr.Dispatch(EventType.Dorm_GetWorldTheme, proto)
end

-- 使用主题(返回房间更新)
function DormProto:UseTheme(_furnitures)
    local proto = {"DormProto:UseTheme", {
        furnitures = _furnitures
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UseThemeRet(proto)
    -- EventMgr.Dispatch(EventType.Dorm_Screenshot, DormMgr:GetScreenshotFileName(proto.id)) --rui 取消了分享暂屏蔽
end

-- 购买主题
function DormProto:BuyTheme(_themeId, _useCost)
    local proto = {"DormProto:BuyTheme", {
        themeId = _themeId,
        useCost = _useCost
    }}
    NetMgr.net:Send(proto)
end
-- 后端不会更新主题列表、和购买记录，自己添加
function DormProto:BuyThemeRet(proto)
    DormMgr:BuyThemeRet(proto)
    EventMgr.Dispatch(EventType.Dorm_Theme_Buy, proto)
end

-- 收藏主题
function DormProto:StoreTheme(_themeId, _isCancel, _StoreThemeCB)
    self.StoreThemeCB = _StoreThemeCB
    local proto = {"DormProto:StoreTheme", {
        themeId = _themeId,
        isCancel = _isCancel
    }}
    NetMgr.net:Send(proto)
end
function DormProto:StoreThemeRet(proto)
    if (proto.isCancel) then
        DormMgr:RemoveThemeData(ThemeType.Store, proto.themeId)
        --收藏是否已为0 ,移除图片
        if(proto.info and proto.info.store and proto.info.store<1) then 
            DormMgr:RemoveImg(proto.info.img)
        end 
    else
        DormMgr:SaveThemeData(ThemeType.Store, proto.info)
    end
    if (self.StoreThemeCB) then
        self.StoreThemeCB(proto)
    end
    self.StoreThemeCB = nil
end

-- 点赞主题
function DormProto:AgreeTheme(_themeId, _isCancel, _AgreeThemeCB)
    self.AgreeThemeCB = _AgreeThemeCB
    local proto = {"DormProto:AgreeTheme", {
        themeId = _themeId,
        isCancel = _isCancel
    }}
    NetMgr.net:Send(proto)
end
function DormProto:AgreeThemeRet(proto)
    if (self.AgreeThemeCB) then
        self.AgreeThemeCB(proto)
    end
    self.AgreeThemeCB = nil
end

-- 分享主题
function DormProto:ShareTheme(_id, _name, _themeId)
    -- self.ShareTheme = _ShareTheme
    local proto = {"DormProto:ShareTheme", {
        id = _id,
        name = _name,
        themeId = _themeId
    }}
    NetMgr.net:Send(proto)
end
function DormProto:ShareThemeRet(proto)
    DormMgr:ShareThemeRet(proto)
    -- if(self.ShareTheme) then
    -- 	self.ShareTheme()
    -- end
    -- self.ShareTheme = nil
end

-- 取消分享主题
function DormProto:UnShareTheme(_themeId)
    local proto = {"DormProto:UnShareTheme", {
        themeId = _themeId
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UnShareThemeRet(proto)
    DormMgr:ShareThemeRet(proto, true)
end

-- 保存 自由主题
function DormProto:SaveTheme(_name, _furnitures, _comfort, _lv, _img)
    local proto = {"DormProto:SaveTheme", {
        name = _name,
        furnitures = _furnitures,
        comfort = _comfort,
        lv = _lv,
        img = _img
    }}
    NetMgr.net:Send(proto)
    EventMgr.Dispatch(EventType.Dorm_Screenshot, {_img,true})
end
function DormProto:SaveThemeRet(proto)
    DormMgr:SaveThemeData(ThemeType.Save, proto.info)
    EventMgr.Dispatch(EventType.Dorm_SaveTheme_Change)
end

-- 移除 自由主题
function DormProto:UnSaveTheme(_themeId)
    local proto = {"DormProto:UnSaveTheme", {
        themeId = _themeId
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UnSaveThemeRet(proto)
    DormMgr:RemoveThemeData(ThemeType.Save, proto.themeId)
    EventMgr.Dispatch(EventType.Dorm_SaveTheme_Change)
end

-- 处理宿舍事件
function DormProto:TakeEvent(_id, _roleId)
    local proto = {"DormProto:TakeEvent", {
        id = _id,
        roleId = _roleId
    }}
    NetMgr.net:Send(proto)
end
function DormProto:TakeEventRet(proto)

end

-- 宿舍开启（走房间更新）
function DormProto:Open(_id)
    local proto = {"DormProto:Open", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function DormProto:OpenRet(proto)
    EventMgr.Dispatch(EventType.Dorm_Update)
end

-- 使用服装
function DormProto:UseClothes(_roleId, _itemIds)
    local proto = {"DormProto:UseClothes", {
        roleId = _roleId,
        itemIds = _itemIds
    }}
    NetMgr.net:Send(proto)
end
function DormProto:UseClothesRet(proto)
    local _data = CRoleMgr:GetData(proto.roleId)
    _data:ChangeClothes(proto.itemIds)
    EventMgr.Dispatch(EventType.Dorm_Change_Clothes, proto)
end

-- 家具购买记录
function DormProto:BuyRecord()
    local proto = {"DormProto:BuyRecord"}
    NetMgr.net:Send(proto)
end
function DormProto:BuyRecordRet(proto)
    DormMgr:BuyRecordRet(proto)
end

-- 家具购买
function DormProto:BuyFurniture(_infos, _useCost, _BuyFurnitureCB)
    self.BuyFurnitureCB = _BuyFurnitureCB
    local proto = {"DormProto:BuyFurniture", {
        infos = _infos,
        useCost = _useCost
    }}
    NetMgr.net:Send(proto)
end
-- 后端不会刷新记录，需要自己刷新 (如果完成主题购买，则刷新主题购买记录（系统推送）)
function DormProto:BuyFurnitureRet(proto)
    DormMgr:BuyFurnitureRet(proto)
    EventMgr.Dispatch(EventType.Dorm_Furniture_Buy)
    if (self.BuyFurnitureCB) then
        self.BuyFurnitureCB()
    end
    self.BuyFurnitureCB = nil
end

-- 查找主题
function DormProto:SearchTheme(_themeId, _SearchThemeCB)
    self.SearchThemeCB = _SearchThemeCB
    local proto = {"DormProto:SearchTheme", {
        themeId = _themeId
    }}
    NetMgr.net:Send(proto)
end
function DormProto:SearchThemeRet(proto)
    if (self.SearchThemeCB) then
        self.SearchThemeCB(proto)
    end
    self.SearchThemeCB = nil
end

-- 家具购买记录
function DormProto:DormPetInfo()
    local proto = {"DormProto:DormPetInfo"}
    NetMgr.net:Send(proto)
end
function DormProto:DormPetInfoRet(proto)
    DormPetMgr:DormPetInfoRet(proto.info)
end

function DormProto:SetPet(_info)
        local proto = {"DormProto:SetPet", {
        info = _info
    }}
    NetMgr.net:Send(proto)
end
function DormProto:SetPetRet(proto)
    EventMgr.Dispatch(EventType.Dorm_SetRoleList)
end


