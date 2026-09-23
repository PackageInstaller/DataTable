-- 角色皮肤信息界面
local list = nil;
local nowIdx = 1;
local lastIdx=1;
local layout = nil;
local svUtil = nil;
local roleItem=nil;
local l2dOn=true;
local curModelCfg=nil;
local btnFuncS=nil;
local btnFuncC=nil;
local card=nil;
local currSkinInfo=nil
local rSkinInfo=nil;--RoleSkinInfo
local eventMgr=nil;
local isFirst=true;
local isInit=false;
local roleItem2=nil
local countDown=0.46;
local hasL2d=false;
local isShowImg=false;
local changeInfo=nil;
local comm=nil;
local shopPriceKey=ShopPriceKey.jCosts;
local bindComm=nil;
local asmrClicker=nil;
local rmbIcon=nil;
local SDKdisplayPrice=nil;
function Awake()
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RoleSkinComm/SkinInfoItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange);
    svUtil = SVCenterDrag.New();
    roleItem = RoleTool.AddRole(item1, nil, nil, false)		
    UIUtil:AddTop2("SkinFullInfo", root, Close,nil,{});
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, OnCardUpdate)
    eventMgr:AddListener(EventType.Card_Skin_Get, Refresh)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh,OnBuyRet)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet);
    asmrClicker=ComUtil.GetCom(btnASMR,"Image");
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    --     l2dOn=RoleSkinMgr:GetL2DState()==true;
    if data then
        list = data.list
        nowIdx = data.idx or 1;
    else
        list = {};
    end
    if list and #list > 0 then
        svUtil:Init(layout,#list,{276,500},7,0.1,0.5);
        layout:IEShowList(#list, function()
            if not isInit then
                isInit=true;
                OnValueChange();
            end
        end, nowIdx);
    end
    Refresh();
end


function Refresh()
    if list and #list > 0 then
        currSkinInfo = list[nowIdx];
        rSkinInfo=nil;
        card=nil
        if currSkinInfo then
            -- 获取L2D按钮状态
            hasL2d=currSkinInfo:HasL2D();
            curModelCfg=currSkinInfo:GetModelCfg();
            local cards=RoleMgr:GetCardsByCfgID(curModelCfg.role_id);
            rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
            if cards then
                card=cards[1]
            end
            comm=ShopCommFunc.GetSkinCommodity(currSkinInfo:GetModelID());
            rmbIcon=comm:GetCurrencySymbols();
            SDKdisplayPrice=comm:GetSDKdisplayPrice();
            --屏蔽
            local useL2d=false;
            isShowImg=false;
            if g_FHXOpenSkin ~= true then
                useL2d=l2dOn;
                if comm and comm:IsShowImg() and rSkinInfo and rSkinInfo:CheckCanUse() ~= true then
                    useL2d = false;
                    isShowImg = true;
                    CSAPI.SetGOActive(btnL2D, false);
                else
                    CSAPI.SetGOActive(btnL2D, hasL2d);
                end
            else
                l2dOn=false;
                CSAPI.SetGOActive(btnL2D, false);
            end
            -- 初始化立绘
            roleItem.Refresh(currSkinInfo:GetModelID(), LoadImgType.SkinFull,nil,useL2d,isShowImg)
            -- 初始化L2D按钮状态
            SetL2DState(useL2d);
            --设置描述
            CSAPI.SetText(txt_desc,currSkinInfo:GetDesc());
            SetASMRInfo();
            SetContent();
            changeInfo=currSkinInfo:GetChangeInfo();
            SetChangeInfo();
            local icons=currSkinInfo:GetTagIcons();
            if icons~=nil then
                for i, v in ipairs(icons) do
                    CSAPI.SetGOActive(this[("tag"..i)],true)
                    ResUtil.Tag:Load(this[("tagIcon"..i)],v);
                end

            end
            if icons==nil or #icons<3 then
                local index= icons~=nil and #icons+1 or 1;
                for i=index,3 do
                    CSAPI.SetGOActive(this[("tag"..i)],false)
                end
            end
        else
            curModelCfg=nil;
        end
    else
        currSkinInfo=nil;
        curModelCfg=nil;
        card=nil;
        rSkinInfo=nil;
        LogError("无皮肤列表");
    end
    SetArrow(nowIdx);
end

function SetASMRInfo()
    if comm then
        local bindID=comm:GetBundlingID();
        CSAPI.SetGOActive(btnASMR,bindID~=nil);
        if bindID then --初始化绑定物品信息
            bindComm=ShopMgr:GetFixedCommodity(bindID);
            if bindComm then
                local isLock=bindComm:GetBuySum()<=0
                --加载图标
                ResUtil.ASMRShop:Load(asmrIcon,bindComm:GetIcon());
                -- CSAPI.SetGOActive(asmrLock,isLock);
                -- CSAPI.SetAnchor(asmrDisk,isLock and 0 or 72,0);
                CSAPI.SetAnchor(asmrDisk,72,0);
                asmrClicker.raycastTarget=not isLock;
                CSAPI.SetGOActive(asmrLock,false);
            end
        end
    end
end

function OnBuyRet()
    --SetASMRInfo();
    Refresh();
end

function SetChangeInfo()
    if changeInfo then
        local type=changeInfo[1].cfg.skinType;
        local langID=18104;
        local otherImgName="img_12_01";
        if type==3 then--同调
            langID=18105;
            otherImgName="img_12_02";
        elseif type==4 then --形切
            langID=18106;
            otherImgName="img_12_03";
        elseif type==5 then --机神
            langID=18104;
        end
        CSAPI.SetText(txt_other,LanguageMgr:GetByID(langID));
        --加载图
        ResUtil.Card:Load(otherIcon, changeInfo[1].cfg.List_head);
        otherImgName=string.format("UIs/RoleSkinComm/%s.png",otherImgName);
        CSAPI.LoadImg(otherImgTips,otherImgName,true,nil,true);
        CSAPI.SetGOActive(btnOther,true);
    else
        CSAPI.SetGOActive(btnOther,false);
    end
end

function SetPriceNode(isShow)
    CSAPI.SetGOActive(btnSwitch,isShow);
    CSAPI.SetAnchor(txt_tips,0,isShow and -160 or -185);
    if isShow and comm and comm:HasOtherPrice(ShopPriceKey.jCosts1) then
        local cost=comm:GetRealPrice(ShopPriceKey.jCosts)[1];
        local cost2=comm:GetRealPrice(ShopPriceKey.jCosts1)[1];
        --加载图标和内容
        CSAPI.SetGOActive(dMNode1,cost.id~=-1 )
        CSAPI.SetGOActive(pnIcon1,cost.id==-1 )
        if cost.id~=-1 then
            ShopCommFunc.SetPriceIcon(dMIcon1,cost);
        else
            CSAPI.SetText(pnIcon1,rmbIcon);
        end
        CSAPI.SetGOActive(dMNode2,cost2.id~=-1 )
        CSAPI.SetGOActive(pnIcon2,cost2.id==-1 )
        if cost2.id~=-1 then
            ShopCommFunc.SetPriceIcon(dMIcon2,cost2);
        else
            CSAPI.SetText(pnIcon2,rmbIcon);
        end
        CSAPI.SetText(txt_dPrice1,tostring(cost.num));
        CSAPI.SetText(txt_dPrice2,tostring(cost2.num));
        if SDKdisplayPrice~=nil then CSAPI.SetText(txt_dPrice1,tostring(SDKdisplayPrice)); end
    end
    if isShow then
        SetPriceNodeStyle();
    end
end

function OnClickSwitch()
    shopPriceKey=shopPriceKey==ShopPriceKey.jCosts1 and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    SetPriceNodeStyle();
end

function SetPriceNodeStyle()
    local isOn=shopPriceKey==ShopPriceKey.jCosts and true or false
    CSAPI.SetAnchor(p1Bg,isOn and -86 or 86,0);
    local c1=isOn and {0,0,0,255} or {255,255,255,255}
    local c2=isOn and {255,255,255,255} or {0,0,0,255} 
    CSAPI.SetTextColor(txt_dPrice1,c1[1],c1[2],c1[3],c1[4]);
    CSAPI.SetTextColor(txt_dPrice2,c2[1],c2[2],c2[3],c2[4]);
    CSAPI.SetTextColor(pnIcon1,c1[1],c1[2],c1[3],c1[4]);
    CSAPI.SetTextColor(pnIcon2,c2[1],c2[2],c2[3],c2[4]);
end

function SetContent()
    -- 设置购买状态
    if currSkinInfo==nil then
        CSAPI.SetGOActive(btnCurrent,false);
        CSAPI.SetGOActive(btnSuit,false);
        return;
    end
    local getType,getTips=currSkinInfo:GetWayInfo();
    local has=false;
    if rSkinInfo and rSkinInfo:CheckCanUse() and rSkinInfo:IsLimitSkin()~=true then
        has=true;
    end
    SetPriceNode(false);
    if has then
        if card then
            --判断当前是否穿戴着该皮肤
            local isSuit=card:GetSkinID()==currSkinInfo:GetModelID();
            CSAPI.SetGOActive(btnCurrent,isSuit);
            CSAPI.SetGOActive(btnSuit,not isSuit);
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18061));
            local lid=isSuit and 18064 or 18065;
            CSAPI.SetText(txt_tips,LanguageMgr:GetByID(lid));
            SetClickFuncS(OnClickEquip);
            SetClickFuncC(nil)
        else
            CSAPI.SetText(txt_tips,LanguageMgr:GetByID(18066));
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,false);
            SetClickFuncC(nil)
        end
    else 
        if getType==SkinGetType.Store then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(1007));
            if comm~=nil and comm:GetNowTimeCanBuy() then
                if comm:GetBundlingType()==ShopCommBindType.Bindling and bindComm then
                    CSAPI.SetText(txt_tips,string.format(LanguageMgr:GetByID(18123),curModelCfg.key,curModelCfg.desc,bindComm:GetName()));
                elseif currSkinInfo:HasL2D()~=true then
                    CSAPI.SetText(txt_tips,string.format(LanguageMgr:GetByID(18133),curModelCfg.key,curModelCfg.desc));
                else
                    CSAPI.SetText(txt_tips,string.format(LanguageMgr:GetByID(18067),curModelCfg.key,curModelCfg.desc));
                end
                SetOrgPrice()
            else
                CSAPI.SetText(txt_tips,LanguageMgr:GetByID(18056));
            end
            SetClickFuncS(OnClickBuy);
            CSAPI.SetGOActive(btnCurrent,false);
            --判断商品是否在购买期限内
            local isBtnShow=false
            if curModelCfg and curModelCfg.shopId and comm then
                isBtnShow=comm:GetNowTimeCanBuy();
            end
            CSAPI.SetGOActive(btnSuit,isBtnShow);
            if isBtnShow and comm and comm:HasOtherPrice(ShopPriceKey.jCosts1) then
                SetPriceNode(isBtnShow);
            end
        elseif getType==SkinGetType.Archive then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18062));
            CSAPI.SetText(txt_tips,getTips);--暂用
            SetClickFuncS(OnClickJump);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,true);
        elseif getType==SkinGetType.Other then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18063));
            CSAPI.SetText(txt_tips,getTips);
            SetClickFuncS(OnClickJump);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,true);
        else
            CSAPI.SetText(txt_tips,getTips);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,false);
            SetClickFuncC(nil)
            SetClickFuncS(nil)
        end
    end
end

function SetOrgPrice()
    if comm~=nil then
        local orgCosts=comm:GetOrgCostsByCostKey(shopPriceKey);
        CSAPI.SetGOActive(discountInfo,orgCosts~=nil);
        if orgCosts~=nil then
            CSAPI.SetText(txt_discount2,tostring(orgCosts[2]));
            --计算倒计时
            local timeTips=comm:GetOrgEndBuyTips()
            CSAPI.SetGOActive(dsInfo2,timeTips~=nil)
            if timeTips then
                CSAPI.SetText(txtDSTime,timeTips);
            end
            if orgCosts[1]~=-1 then
                CSAPI.SetGOActive(dsMoneyIcon,true);
                CSAPI.SetGOActive(txt_dsRmb,false);
                local cfg = Cfgs.ItemInfo:GetByID(orgCosts[1],true);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(dsMoneyIcon, cfg.icon.."_1");
                else
                    LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
                end
            else
                CSAPI.SetGOActive(dsMoneyIcon,false);
                CSAPI.SetText(txt_dsRmb,comm:GetCurrencySymbols(true))
                CSAPI.SetGOActive(txt_dsRmb,true);
            end
            -- CSAPI.SetTextColorByCode(txt_price,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_rmb,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_rmbVal,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_price3,"FFC146");
            if #orgCosts==3 then
                CSAPI.SetTextColorByCode(this["pnIcon"..orgCosts[3]],"FFC146");
                CSAPI.SetTextColorByCode(this["txt_dPrice"..orgCosts[3]],"FFC146");
            else
                CSAPI.SetTextColorByCode(pnIcon1,"FFFFFF");
                CSAPI.SetTextColorByCode(pnIcon2,"FFFFFF");
                CSAPI.SetTextColorByCode(txt_dPrice1,"FFFFFF");
                CSAPI.SetTextColorByCode(txt_dPrice2,"FFFFFF");
            end
        else
            CSAPI.SetTextColorByCode(pnIcon1,"FFFFFF");
            CSAPI.SetTextColorByCode(pnIcon2,"FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice1,"FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice2,"FFFFFF");
        end
    end
end

function OnCardUpdate()
    Tips.ShowTips(LanguageMgr:GetByID(18072));
    Refresh();
end

function LayoutCallBack(index)
    local _data = list[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index);
    item.SetSelect(index==nowIdx);
    item.SetClickCB(OnClickItem)
end

function OnValueChange()
    local index=layout:GetCurIndex();
    if index+1~=nowIdx then
        local item = layout:GetItemLua(nowIdx)
        if item then
            item.SetSelect(false);
        end
        lastIdx=nowIdx;
        nowIdx=index+1
        local item = layout:GetItemLua(nowIdx)
        if(item) then 
            item.SetSelect(true);
            shopPriceKey=ShopPriceKey.jCosts;
        end 
        if not isFirst then
            FuncUtil:Call(function()
                if nowIdx<lastIdx then
                    PlayMoveTween(true);
                else
                    PlayMoveTween();
                end
            end,nil,1)
        end
        SetArrow(nowIdx);
    end
    svUtil:Update();
end

function SetArrow(nowIdx)
    if nowIdx<=1 then
        CSAPI.SetImgColor(arrow1,255,255,255,122);
        CSAPI.SetImgColor(arrow2,255,255,255,255);
    elseif nowIdx==#list then
        CSAPI.SetImgColor(arrow1,255,255,255,255);
        CSAPI.SetImgColor(arrow2,255,255,255,122);
    else
        CSAPI.SetImgColor(arrow1,255,255,255,255);
        CSAPI.SetImgColor(arrow2,255,255,255,255);
    end
end

function OnClickItem(tab)
    layout:MoveToCenter(tab.GetIndex());
end

function OnClickL2D()
    l2dOn=not l2dOn;
    Refresh();
end

function SetClickFuncS(func)
    btnFuncS=func
end

function SetClickFuncC(func)
    btnFuncC=func
end

function OnClickSuit()
    if btnFuncS then
        btnFuncS();
    end
end

function OnClickCurrent()
    if btnFuncC then
        btnFuncC();
    end
end

--进入立绘查看界面
function OnClickSearch()
    if curModelCfg then
        OpenSearchView({curModelCfg.id, l2dOn,isShowImg}, LoadImgType.Main)
    end
end

function OpenSearchView(data,loadImgType)
    if data~=nil then
        CSAPI.OpenView("RoleInfoAmplification", data,loadImgType)
    end
end

function OnClickOther()
    if changeInfo then
        local cfg=changeInfo[1].cfg;
        local type=changeInfo[1].type;
        local isShowImg2=isShowImg;
        local tips=nil;
        local desc="";
        if type==5 then
            isShowImg2=false;
        end
        desc=LanguageMgr:GetByID(18102,currSkinInfo:GetRoleName(),cfg.desc);
        if g_FHXOpenSkin ~= true then
            OpenSearchView({cfg.id, type==SkinChangeResourceType.Spine,isShowImg2,desc}, LoadImgType.Main)
        else
            --和谐更改
            OpenSearchView({cfg.id, type==SkinChangeResourceType.Image,isShowImg2,desc}, LoadImgType.Main)
        end
    end
end

function Close()
    -- 缓存L2D按钮的状态
    RoleSkinMgr:SetL2DState(l2dOn);
    view:Close();
end

function SetL2DState(isOn)
    local name="UIs/RoleSkinComm/btn_03_03.png";
    if isOn then
        name="UIs/RoleSkinComm/btn_03_02.png";
    end
    CSAPI.LoadImg(l2dState,name,true,nil,true);
end

--点击穿戴
function OnClickEquip()
    if card and currSkinInfo then
        local skin_a = RoleTool.GetBDSkin_a(card:GetCfgID(), currSkinInfo:GetModelID())
        RoleSkinMgr:UseSkin(card:GetID(), currSkinInfo:GetModelID(), skin_a,l2dOn,l2dOn)
    end
end

--跳转
function OnClickJump()
    if currSkinInfo then
        local jumpID=currSkinInfo:GetBuyInfo()
        if jumpID then
            JumpMgr:Jump(jumpID[1]);
        end
    end
end

--购买
function OnClickBuy()
    --打开购买界面
    -- local comm=ShopCommFunc.GetSkinCommodity(currSkinInfo:GetModelID());
    if comm then
        local cost=comm:GetRealPrice(shopPriceKey);
        if cost==nil or(cost~=nil and cost[1].id~=-1)  then
            CSAPI.OpenView("ShopSkinBuy",comm,shopPriceKey);
        elseif (cost~=nil and cost[1].id==-1) then
            ShopCommFunc.HandlePayLogic(comm,1,nil,OnSuccess,shopPriceKey);
        end
    end
end

function OnSuccess(proto)
    -- EventMgr.Dispatch(EventType.Card_Skin_Get)
    if currSkinInfo and proto and next(proto.gets) then
        CSAPI.OpenView("SkinShowView",currSkinInfo)
    end
end

-- --播放立绘移动动画 isRTL:是否从右到左
-- function PlayMoveTween(isRTL)
--     CSAPI.SetGOActive(anim_left_out, true)
--     CSAPI.SetGOActive(anim_left_int, false)
--     local x1 = 0
--     local x2 = isRTL and 400 or -400
--     UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
--         Refresh()
--         CSAPI.SetGOActive(anim_left_out, false)
--         CSAPI.SetGOActive(anim_left_int, true)
--         UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 100)
--     end, 300, 0)
-- end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    -- LogError(tostring(isShowImg))
    if(not isShowImg and hasL2d) then 
        UIUtil:SetObjFade(item1, 1, 0, nil, 1, 300, 1)
    else 
        UIUtil:SetObjFade(item1, 1, 0, nil, 300, 1, 1)
    end 
    UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
        Refresh()
        if(not isShowImg and hasL2d) then 
            UIUtil:SetObjFade(item1, 0, 1, nil, 1, 300, 0)
        else 
            UIUtil:SetObjFade(item1, 0, 1, nil, 300, 1, 0)
        end 
        UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end


local holdDownTime = 0
local holdTime = 0.1
local startPosX = 0

function OnPressDown(isDrag, clickTime)
    holdDownTime = Time.unscaledTime
    startPosX = CS.UnityEngine.Input.mousePosition.x
end

function OnPressUp(isDrag, clickTime)
    if Time.unscaledTime - holdDownTime >= holdTime then
        local len = CS.UnityEngine.Input.mousePosition.x - startPosX
        if (math.abs(len) > 100) then
            local index=nowIdx
            if (len > 0) then
                 --图片左移
                 index=nowIdx-1<=0 and 0 or nowIdx-1;
            else
                --图片右移
                index=nowIdx+1>=#list and #list or nowIdx+1;
            end
            if index~=nowIdx then
                layout:MoveToCenter(index);
            end
        end
    end
end

function Update()
    if isFirst then
        countDown=countDown-Time.deltaTime;
        if countDown<=0 then
            isFirst=false;
            CSAPI.SetGOActive(mask,false);
        end
    end
end

function OnClickTag()
    --显示当前图标的描述
    if currSkinInfo then
        CSAPI.OpenView("SkinTagDesc",currSkinInfo);
    end
end

function OnClickASMR()
    if bindComm and comm then
        local isLock=bindComm:GetBuySum()<=0
        if isLock then --根据绑定类型做逻辑，未解锁前无法点击
            -- if comm:GetBundlingType()== ShopCommBindType.Show then--点击弹出购买窗口
            --     local pageData=ShopMgr:GetPageByID(bindComm:GetShopID());
            --      ShopCommFunc.OpenPayView(bindComm,pageData);
            -- else
            --     OnClickBuy();
            -- end
        else --弹出跳转确认窗口
            local dialogdata = {
                content = LanguageMgr:GetTips(46003),
                okCallBack = function()
                   JumpMgr:Jump(80003);
                end
            }
            CSAPI.OpenView("Dialog", dialogdata);
        end
    end
end