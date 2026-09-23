--local this=MgrRegister("ShiryuSDK")
require "AdvGoogleGit";
require "AdvGuiDeScore"
require "AdvBindingRewards"
require "AdvDeductionvoucher"
require "AdaptiveConfiguration"
require "RegionalSet"
ShiryuSDK={}
local  this=ShiryuSDK;

if CSAPI.IsADV() or CSAPI.IsDomestic() then
    if CSAPI.RegionalCode()==6 then
        MJSdkManagerImpl=CS.EUSdkChannelImpl.EUSdkMgrImpl:GetInstance();
    else
        MJSdkManagerImpl=CS.MJSdkBridge.MJSdkManagerImpl:GetInstance();
    end
CShiryuSDK=CS.ShiryuSDK.Instance;
end
---2.SDK获取数据
this.SdkProperties={}
this.SdkProperties.gid=0;
this.SdkProperties.cid=0;
this.SdkProperties.cid2=0;
this.SdkProperties.channelProperties={}  --词典--Item ：1.appKey 2.channelId 3.ecid 4.deviceId
---3.登录获取数据返回（数据需要上传到游戏服务器）
this.ShiryuLogin={}
this.ShiryuLogin.success=false;
this.ShiryuLogin.uid="";
this.ShiryuLogin.token="";
this.ShiryuLogin.channelExts={} ---opcode、operators、appKey、channelId、ecid、deviceId，did（打点参数）

this.ShiryuActivitys = {}
this.ShiryuActivitys.list = {}
this.ShiryuActivitys.Dic = {}

this.ShiryuGoodsList={}
this.ShiryuGoodsList.success=false;
this.ShiryuGoodsList.goodsList= { };
this.ShiryuGoodsList.goodsidDic= { };
this.GetSdkProperties={};
--Item:
---skuCode string      充值id
---productName string  商品名称
---amount  int  定价商品价格（单位分）
---currency  string  定价币种
---productDesc  string  充值商品描述。
---goodsId  string  应用商店的商品id
---voucherId  string  这个商品对应使用的抵扣劵ID
---type int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
--- displayCurrency  string  显示币种的标准货币代码（例如：USD，CNY）
--- displayPrice   string  显示价格
---服务端返回登录数据
this.Serverlogin={}

---脚本是否重复初始化
this.IsInit=false;
---SDK初始化 是否成功
this.SDKinit=false;
---登录页面  切换账号
this.LoginViewSwitchAccounts=false;
---是否已经进入大厅
this.IsEnterhall=false;

---string
---千禧，全球包：1170，俄语包：1169
this.Unityqianxi_game_id="";
---string
---千禧，476：全球-谷歌包，477：全球-官网包， 478：全球-iOS包，472：RU-谷歌包，473：RU-官网包，474：RU-iOS包
this.Unityqianxi_app_id="";
---string
---千禧，331：谷歌包，334：官网包，332：iOS包
this.Unityqianxi_channel_id="";
---string
---千禧，101：谷歌包，201：iOS包，1201：iOS内部测试包名，102：官网1包，103：官网2包，104：官网3包，
this.Unityqianxi_publish_id="";
function this.Init()
    if this.IsInit then return; end
    this.IsInit=true
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        Log("zilong SDK Init  ----start")
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Init_complete,this.SDKShiryuSDKInitcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_GetSdkProperties_complete,this.SDKShiryuSDKGetSdkPropertiescomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Login_complete,this.SDKShiryuSDKLogincomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_SetLogoutCallback_complete,this.SDKShiryuSDKSetLogoutCallbackcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_GetGoodsList_complete,this.SDKShiryuSDKGetGoodsListcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Pay_complete,this.SDKShiryuSDKPaycomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_GetActivitys_Complete,this.SDKShiryuSDKGetActivitysComplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Redeem_Complete,this.SDKShiryuSDKRedeemComplete)
    end
end
---1.SDK初始化完成返回
function this.SDKShiryuSDKInitcomplete(datapacket)
    Log("-zilong--SDK init Success--------end---------------")
    this.LoginSDK();
end

function this.LoginSDK()
    if this.SDKinit then
        if this.ShiryuLogin.success==false then
            Log("----------GetCommonData--------Rest----------------")
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetSdkProperties)
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
            this.GetCommonData();
        end
        return;
    end
    this.SDKinit=true
    this.SDKinterfacelisten();


    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetSdkProperties)
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
    this.GetCommonData();
end

---获取通用常规数据
function this.GetCommonData()
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetGoodsList)
    
    -- 暂未启用中台的获取活动接口
    -- this.GetActivitys()
end
---2.获取SDK数据
function this.SDKShiryuSDKGetSdkPropertiescomplete(datapacket)
    --print("--------Lua 输出数据"..table.tostring(datapacket))
    this.GetSdkProperties={};
    local isAdv = CSAPI.IsADV()
    if datapacket then
        for i, v in pairs(datapacket) do
            --- LogError("--------Lua--------key:"..i.." value:"..v);
            this.GetSdkProperties[i]=v;
            if isAdv and tostring(i)=="ecid" then
                AdvGoogleGit.ecid=v;
                AdvGuiDeScore.Setecid(v)
            elseif isAdv and CSAPI.RegionalCode()==6 and tostring(i)=="publish_id" then
                this.Unityqianxi_publish_id=v
                LogError("publish_id:"..v)
            end
        end
    end
end

---4.登录数据返回
function this.SDKShiryuSDKLogincomplete(datapacket)
    if  this.ShiryuLogin.success then  LogError("存在账号重复登录未退登行为！主动退登")   this.Logout() return ; end
    this.ShiryuLogin={}
    this.ShiryuLogin.success=datapacket.success;
    this.ShiryuLogin.uid=datapacket.uid;
    this.ShiryuLogin.token=datapacket.token;
    this.ShiryuLogin.channelExts={}
    local isAdv = CSAPI.IsADV()
    if datapacket.channelExts then
        for i, v in pairs(datapacket.channelExts) do
            ---LogError("key:"..i.." value:"..v);
            this.ShiryuLogin.channelExts[i]=v;
            if isAdv and tostring(i)=="ecid" then
                AdvGoogleGit.ecid=v;
                AdvGuiDeScore.Setecid(v)
            elseif isAdv and CSAPI.RegionalCode()==6 and tostring(i)=="publish_id" then
                this.Unityqianxi_publish_id=v
                LogError("publish_id:"..v)
            end
        end

    end
    if this.ShiryuLogin.success then
        this.GetCommonData();
        Log("-------------Login -success---------------------")
    else
        Log("-------------Login -fail-----------------------")
    end
    local LoginBackData=table.tostring(this.ShiryuLogin,true);
    BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_SDK_LuaLoginData,{SDKShiryuLoginBackData=LoginBackData})
end

---5.退出登录成功返回
function this.SDKShiryuSDKSetLogoutCallbackcomplete(datapacket)
    ---LogError("SDKShiryuSDKSetLogoutCallbackcomplete")
    ---LogError(datapacket)
end
---8.获取商品列表返回
function this.SDKShiryuSDKGetGoodsListcomplete(datapacket)

    if CSAPI.IsADV() or CSAPI.IsDomestic() then        
        this.ShiryuGoodsList={}
        this.ShiryuGoodsList.success=datapacket.success;
        this.ShiryuGoodsList.goodsList= { };
        this.ShiryuGoodsList.goodsidDic= { };

        if datapacket.goodsList  then
            local index=0;
            for i, v in pairs(datapacket.goodsList) do
                index=index+1
                local Item={}
                Item.skuCode=datapacket.goodsList[i].skuCode;
                Item.productName=datapacket.goodsList[i].productName;
                Item.amount=datapacket.goodsList[i].amount;
                Item.currency=datapacket.goodsList[i].currency;
                Item.productDesc=datapacket.goodsList[i].productDesc;
                Item.goodsId=datapacket.goodsList[i].goodsId;
                Item.voucherId=datapacket.goodsList[i].voucherId;
                Item.type=datapacket.goodsList[i].type;
                Item.displayCurrency=datapacket.goodsList[i].displayCurrency;
                Item.displayPrice=datapacket.goodsList[i].displayPrice;
                table.insert(this.ShiryuGoodsList.goodsList,index,Item)
                this.ShiryuGoodsList.goodsidDic[tostring(Item.skuCode)]=Item;
            end
        end
        this.InitShopData()
    end
    --Item:
    ---skuCode string      充值id
    ---productName string  商品名称
    ---amount  int  定价商品价格（单位分）
    ---currency  string  定价币种
    ---productDesc  string  充值商品描述。
    ---goodsId  string  应用商店的商品id
    ---voucherId  string  这个商品对应使用的抵扣劵ID
    ---type int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
    --- displayCurrency  string  显示币种的标准货币代码（例如：USD，CNY）
    --- displayPrice   string  显示价格
end

---首次 初始化表后，进行对基础表增加或者修改内容，根据SDK返回
function this.InitShopData()

    for i, v in pairs(this.ShiryuGoodsList.goodsList) do
        local id=0;
        id=tonumber(this.ShiryuGoodsList.goodsList[i].skuCode);
        local TableShop=Cfgs.CfgCommodity:GetByID(id)
        if TableShop then
            --Cfgs.CfgCommodity:GetByID(id).sName=this.ShiryuGoodsList.goodsList[i].productName      ---string  商品名称
            --Cfgs.CfgCommodity:GetByID(id).sDesc=this.ShiryuGoodsList.goodsList[i].productDesc      --- string  充值商品描述。
            --Cfgs.CfgCommodity:GetByID(id).jCosts[1][2]=tonumber(this.ShiryuGoodsList.goodsList[i].displayPrice)   ---string  显示价格
            Cfgs.CfgCommodity:GetByID(id).currency=this.ShiryuGoodsList.goodsList[i].currency         ---string  定价币种
            Cfgs.CfgCommodity:GetByID(id).amount=this.ShiryuGoodsList.goodsList[i].amount           ---int  定价商品价格（单位分）
            Cfgs.CfgCommodity:GetByID(id).goodsId=this.ShiryuGoodsList.goodsList[i].goodsId          ---string  应用商店的商品id
            Cfgs.CfgCommodity:GetByID(id).voucherId=this.ShiryuGoodsList.goodsList[i].voucherId        ---string  这个商品对应使用的抵扣劵ID
            Cfgs.CfgCommodity:GetByID(id).type=this.ShiryuGoodsList.goodsList[i].type             ---int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
            Cfgs.CfgCommodity:GetByID(id).displayCurrency=this.ShiryuGoodsList.goodsList[i].displayCurrency  ---string  显示币种的标准货币代码（例如：USD，CNY）
            Cfgs.CfgCommodity:GetByID(id).displayPrice=this.ShiryuGoodsList.goodsList[i].displayPrice  ---string  显示价格
            --Cfgs.CfgCommodity:GetByID(id).displayPrice=tonumber(999)   ---string  显示价格
            --Cfgs.CfgCommodity:GetByID(id).displayCurrency="jyp"  ---string  显示币种的标准货币代码（例如：USD，CNY）
        end
    end
end

---节点数据修改
function this.ShopDataEdit(data)
    if data["id"]==nil then
        return data;
    end
    local id=tonumber(data["id"]);
    if this.IsShopExist(id)  then
        ---LogError("----------------满足条件的ID----修改前-------"..id..table.tostring(data))
        local ShopItem=this.ShiryuGoodsList.goodsidDic[tostring(id)]
        --data["sName"]=ShopItem.sName  ---string  商品名称
        -- data["sDesc"]=ShopItem.sDesc  --- string  充值商品描述。
        --data["shop_config"]["jCosts"][1][2]=tonumber(ShopItem.displayPrice) ---string  显示价格
        data["currency"]=ShopItem.currency ---string  定价币种
        data["amount"]=ShopItem.amount ---int  定价商品价格（单位分）
        data["goodsId"]=ShopItem.goodsId  ---string  应用商店的商品id
        data["voucherId"]=ShopItem.voucherId  ---string  这个商品对应使用的抵扣劵ID
        data["type"]=ShopItem.type ---int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
        data["displayCurrency"]=ShopItem.displayCurrency ---string  显示币种的标准货币代码（例如：USD，CNY）
        data["displayPrice"]=ShopItem.displayPrice  ---string  显示价格
        --data["displayPrice"]=tonumber(999) ---string  显示价格
        --data["displayCurrency"]="jyp"  ---string  显示价格
        --- LogError("----------------满足条件的ID-----修改后------"..id..table.tostring(data))
        return data;
    end
    return data;
end
---判断是否存在
function this.IsShopExist(id)
    if this.ShiryuGoodsList.goodsidDic and this.ShiryuGoodsList.goodsidDic[tostring(id)]~=nil then
        return true;
    else
        return false;
    end
end


---9. 支付返回
function this.SDKShiryuSDKPaycomplete(datapacket)
    EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
    --  Log("SDKShiryuSDKGetGoodsListcomplete")
    Log("---------------Payment successful---------------")
    if datapacket.success then
        CSAPI.DispatchEvent(EventType.SDK_Deduction_voucher_paymentcompleted)
        SDKPayMgr:SearchPayReward(true);
    else
        if CSAPI.IsDomestic and  CSAPI.IsDomestic() then

        else
            Tips.ShowTips(LanguageMgr:GetTips(1011));
        end
    end
end

---SDK 初始化成功，接口监听集合
function this.SDKinterfacelisten()
    ShiryuSDK.SetLogoutCallback(ShiryuSDK.LogoutCallback)
    if CSAPI.IsADV() and CSAPI.RegionalCode()~=6 then
        ShiryuSDK.SetCheckGiftCallback(ShiryuSDK.CheckGiftCallback)
    end

end
----------------------------------------------SDK监听回调区域下---------------------------------------------------------------------------------------
function this.LogoutCallback(Success)
    if Success then
        Log("-------------SDK logout-----------------------")
        this.IsEnterhall=false;
        this.ShiryuLogin={}
        this.ShiryuLogin.success=false;
        this.ShiryuLogin.uid="";
        this.ShiryuLogin.token="";
        this.ShiryuLogin.channelExts={} ---opcode、operators、appKey、channelId、ecid、deviceId
        this.IsEnterhall=false;
        if this.LoginViewSwitchAccounts then
            this.LoginViewSwitchAccounts=false;
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
        else
            if CSAPI.IsChannel() then
                EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand,nil,true)
            end
            PlayerClient:SDKExit();
            PlayerClient:Clearuid();
        end
        ClientProto:ClearLoginData()
        PlayerClient:SetEnterHall(false);
    else
        Log("接收到异常退出 失败")
    end
end


function this.CheckGiftCallback(MJGoodsLit)
    print("接收到消息返回：")
    print("接收到消息返回MJGoodsLit："..table.tostring(MJGoodsLit))
    AdvGoogleGit.SDKBackAdvGoogleGitTrue=true;
    if this.IsEnterhall then

        AdvGoogleGit.GoogleReservationRewards();

    else
        print("有奖励，但是处于数据准备阶段")
    end


end


function this.GetActivitys()
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetActivitys)
    -- LogError("---------------GetActivitys---------------")
end
---8.获取商品列表返回
function this.SDKShiryuSDKGetActivitysComplete(activitysDatapacket)

    if CSAPI.IsDomestic() then        
        if activitysDatapacket then
            -- activitysInfo :  struct
            -- string name;     //活动的名称
            -- string imageUrl;     //活动的图片地址
            -- string jumpId;       //活动的跳转Id
            -- string panelId;      //关联面板Id
            -- int sortId;      //序号，游戏需要根据这个字段进行排序
            -- long startTime;      //活动的开始时间，秒级别的时间戳
            -- long endTime;        //活动的开始结束，秒级别的时间戳
            -- string serverId;     //该活动是用于哪个服务器的
            -- string lang;		//该活动是用于哪种语言的
            this.ShiryuActivitys = {}
            this.ShiryuActivitys.list = {}
            this.ShiryuActivitys.Dic = {}

            local index=0;
            for i, v in pairs(activitysDatapacket) do
                index=index+1
                local Item={}
                Item.name=activitysDatapacket[i].name;
                Item.imageUrl=activitysDatapacket[i].imageUrl;
                Item.jumpId=activitysDatapacket[i].jumpId;
                Item.panelId=activitysDatapacket[i].panelId;
                Item.sortId=activitysDatapacket[i].sortId;
                Item.startTime=activitysDatapacket[i].startTime;
                Item.endTime=activitysDatapacket[i].endTime;
                Item.serverId=activitysDatapacket[i].serverId;
                Item.lang=activitysDatapacket[i].lang;
                table.insert(this.ShiryuActivitys.list,index,Item)
                this.ShiryuActivitys.Dic[tostring(Item.name)]=Item;
            end
        end
    end
end

function this.Redeem(code)
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Redeem,code)
    -- LogError("---------------GetActivitys---------------")
end
---8.获取商品列表返回
function this.SDKShiryuSDKRedeemComplete(datapacket)
    if CSAPI.IsDomestic() then        
        if datapacket then
            -- success
            -- msg
            LogError(datapacket.success)
            LogError(datapacket.msg)
        end
    end
end
----------------------------------------------SDK监听回调区域上---------------------------------------------------------------------------------------


---1：初始化SDK
function this.InitSdk(MJSdkEnv,SDKInitCallback)
    MJSdkManagerImpl:InitSdk(MJSdkEnv,SDKInitCallback);
end
---2:获取数据
if CSAPI.IsADV() or CSAPI.IsDomestic() then
    if CSAPI.RegionalCode()==6 then
        this.GetSdkProperties=MJSdkManagerImpl.GetSdkInfos;
    else
        this.GetSdkProperties=MJSdkManagerImpl.GetSdkProperties;
    end
end

---3.是否是审核状态接口
function this.IsReview()
    return CShiryuSDK:IsReview();
end
---4:登录
function this.Login(SDKLoginCallback)
    MJSdkManagerImpl:Login(SDKLoginCallback);
end
---5：登出---退出账号/切换账号时候
function this.Logout()
    print("====================================unity Logout")
    MJSdkManagerImpl:Logout();
end
---6：SDK登出账号成功，游戏需在此做游戏切换账号操作
function this.SetLogoutCallback(SDKLogoutCallback)
    if CSAPI.RegionalCode()==6 then
        MJSdkManagerImpl:SetLogoutListener(SDKLogoutCallback);
    else
        MJSdkManagerImpl:SetLogoutCallback(SDKLogoutCallback);
    end
end
---7_1：角色上报_创建角色
function this.CreateRole()
    ---发送结构参考
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=0;
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnCreateRole,roleInfoTable)
end

---7_2：角色登录进入服务器
function this.OnLoginServer()
    Log("----------------------角色登录进入服务器-------------------------------")
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnLoginServe,roleInfoTable)


end
---7_3：角色数据更新
function this.OnRoleInfoUpdate()
    Log("----------------------角色数据更新-------------------------------")
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnRoleInfoUpdate,roleInfoTable)
end


function this.GetbattleStrength()
    local   teamData=TeamMgr:GetTeamData(1,true)
    local haloStrength=teamData:GetHaloStrength();
    local battleStrength= teamData:GetTeamStrength()+haloStrength
    Log("-------------------------battleStrength------------"..tostring(battleStrength))
    return  battleStrength;
end
---7_4：设置角色名称
function this.OnSetRoleName(roleInfo)
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnSetRoleName,roleInfoTable)
end

---10：游戏退出杀死进程
function this.ExitGame()
    MJSdkManagerImpl:ExitGame();
end

---11.游戏事件上报接口   （调试异常）
function this.TrackEvent(eventName,eventToken,data)
    if eventToken==nil then eventToken="" end
    if data==nil then data= { } end
    CShiryuSDK:TrackEvent(eventName,eventToken,data);
end
---12.此接口获取当前登录的账号是否已绑定
---如果返回False，需要提供一个按钮让用户去绑定页面
---如果是True并且游戏后台记录用户还没领取过奖励，则显示“领取”按钮
function this.IsNeedBinding()
    return CShiryuSDK:IsNeedBinding();
end
-----13.打开绑定账号页面  (存在不回调，Bug未解决)
-----调用此接口打开SDK绑定页面 请在回调里面更新“绑定/领取”按钮的状态
function this.ToBindingPage(action)
    return CShiryuSDK:ToBindingPage(action);
end
-----14.用户中心接口 此接口用于打开用户用心此接口不需要参数和回调
function this.ShowUserCenter()
    return CShiryuSDK:ShowUserCenter();
end
-----15.此接口打开一个页面，如公告，隐私协议，用户协议等
--- 输入值1-20  具体查看C# 枚举类型
function this.ShowSdkCommonUI(type)
    return CShiryuSDK:ShowSdkCommonUI(type);
end
---16.判断显示评价的条件
---只有这个方法返回值等于true，并且满足紫龙要求的显示评价的条件才能弹窗要求用户去评价。
function this.CanShowRateUs()
    if CSAPI.RegionalCode()==6 then
        if tostring(this.Unityqianxi_publish_id) == tostring(101) or
                tostring(this.Unityqianxi_publish_id) == tostring(102) or
                tostring(this.Unityqianxi_publish_id) == tostring(103) or
                tostring(this.Unityqianxi_publish_id) == tostring(201) or
                tostring(this.Unityqianxi_publish_id) == tostring(1201) then
            LogError(" 满足条件this.Unityqianxi_publish_id:"..this.Unityqianxi_publish_id)
            return true
        else
            LogError("不满足条件this.Unityqianxi_publish_id:"..this.Unityqianxi_publish_id)
            return false
        end
    else
        return CShiryuSDK:CanShowRateUs();
    end
end
-----17.游戏内评分接口 游戏在指定的时机调用游戏内评分功能，引导玩家在appstore或者google play store为游戏进行评分
function this.RateUs()
    CShiryuSDK:RateUs();
end
-----18.游戏权限检查接口
function this.CheckPermission(mjSdkPermissionType,action)
    CShiryuSDK:CheckPermission(mjSdkPermissionType,action);
end
-----19.游戏动态授权接口 游戏在使用权限功能时，如果没有权限，需要先调用sdk接口获取相关权限。
function this.RequestPermission(mjSdkPermissionType,action)
    CShiryuSDK:RequestPermission(mjSdkPermissionType,action);
end
-----20.扫描PC二维码登录接口
---Unity编辑器 无法调试
function this.DoStartQRLogin(action)
    CShiryuSDK:DoStartQRLogin(action);
end
-----21.监听待领取的奖励
-----此接口在每次进入区服后都要调用
---此接口在有待领取的奖励时才会回调
-----收到回调后请在合适的时机弹窗询问用户是否将该奖励领取到当前角色
---弹窗条件：
---1、解锁邮件系统已经解锁。
---2、不在强制引导/战斗状态。
---3、如果收到回调时不满足上面两条件，则在满足上面两条件后马上弹出领取提示窗
function this.SetCheckGiftCallback(checkGiftCallback)
    CShiryuSDK:SetCheckGiftCallback(checkGiftCallback);
end
-----22.玩家进到游戏后，判断是否有奖励，如果有奖励，在领取奖励页面点击领取调用此接口  需要第21条返回为true 调用
function this.ClaimGift(paymentInfo,action)
      if CSAPI.RegionalCode()==6 then
        ---英俄分支没这个接口
    else
        CShiryuSDK:ClaimGift(paymentInfo,action);
    end
end


----- 23.打开活动接口 游戏首页“活动”按钮调用此接口
function this.ShowActivityUI(action)
    if CSAPI.RegionalCode()==6 then
        ---英俄分支没这个接口
    else
        CShiryuSDK:ShowActivityUI(action);
    end
end
-----  24.信息通知显示红点接口
-----游戏中的UI上有一些和平台SDK功能相关的按钮，这些按钮有些需要在某些通知事件发生时显示红点以提醒玩家。
-----游戏在适当的时机调用此接口检查信息的状态，并根据查询结果在对应的地方显示红点通知。
-----例如玩家在客服中心提的客服问题，如果客服有答复了，会在“问题解答”按钮上提示红点
---参数1，2,3
function this.QueryRedDotState(mjSdkNoticeType,action)
    if CSAPI.RegionalCode()==6 then
        ---英俄分支没这个接口
    else
        CShiryuSDK:QueryRedDotState(mjSdkNoticeType,action);
    end
end
----- 25.设置语言接口
-----游戏在每次设置游戏语言的时候，需要调用此接口来设置sdk的语言，使sdk的相关界面或者提示中的语言保持和游戏语言一致。
---EN = "en";//英文
---TW = "zh";//繁体
---KR = "ko";//韩语
---JP = "ja";//日语
---CN = "zh_TW";//简体
function this.SetLanguage(language)
    CShiryuSDK:SetLanguage(language);
end
----- 26.抵扣券点数查询接口  （需要进入服务器后才能调）
----- 此接口用于查询用户的抵扣券点数信息
function this.QueryPoints(action)
    if CSAPI.RegionalCode()==6 then
        ---英俄分支没这个接口
    else
        CShiryuSDK:QueryPoints(action);
    end
end
-----27.抵扣点数支付接口
-----游戏需要在玩家点击一个抵扣点数，尝试进行一次充值时调用该方法。
-----支付结果请以服务端通知为准
function this.PayPoints(paymentInfo,action)
    if CSAPI.RegionalCode()==6 then
        ---英俄分支没这个接口
    else
        CShiryuSDK:PayPoints(paymentInfo,action);
    end
end
---28.分享
function this.Share(Jsonstr,action)
    ---参考发送结构 最后转成Json
    --local ShareTable=
    --{
    --    ["Text"]="分享测试内容，分享测试内容",---分享的内容。
    --    ["Title"]="分享测试标题",---分享的标题。
    --    ["ImagePath"]="Application.persistentDataPath".."/Share.jpg",---分享的链接。
    --    ["thumbImagePath"]="Application.persistentDataPath".."thumbShare.jpg",---分享缩略图图片的本地存储地址。要求缩略图为PNG格式大小不超过32k。
    --    ["Url"]="",---分享的链接。
    --    ["shareType"]=tonumber(2),---分享类型，具体的值见下面表格。
    --    ["sharePlatform"]=tonumber(8),---分享平台，具体的值说明见下面表格。
    --    ["para"]="",---分享参数，个别特殊分享使用。例如社区分享的GaragePainting，GaragePaintingCode
    --}
    -- local Jsonstr = Json.Encode(ShareTable)
    CShiryuSDK:Share(Jsonstr,action);
end
---28.设置支付限额接口（日本专用）
---0: 18岁以上，无限制; 1: 16岁以下，每月5000日元; 2: 16~17岁，每月30000日元
function this.SetPayLimitLevel(limitLevel)
    Log("发生支付限制类型："..limitLevel)
    CShiryuSDK:SetPayLimitLevel(limitLevel);
end


---海外千禧---打开外部浏览器接口，仅仅英俄地区使用
function this.OpenUrl(url)
    Log("url："..url)
    CShiryuSDK:OpenUrl(url);
end
---30.激励广告
---scenarioId 场景ID, 目前可以传
function this.ShowRewardAd(rewardAdListener,scenarioId)
    CShiryuSDK:ShowRewardAd(rewardAdListener,scenarioId);
end
---在线
function this.OnRoleOnline()
    if  this.ShiryuLogin.success then

        local roleInfoTable={}
        local serverInfo = GetCurrentServer();
        roleInfoTable.uid=PlayerClient:GetUid();
        roleInfoTable.serverId=serverInfo.id;
        roleInfoTable.serverName=serverInfo.serverName;
        roleInfoTable.roleId=PlayerClient:GetUid();
        roleInfoTable.roleLevel=PlayerClient:GetLv();
        roleInfoTable.roleName=PlayerClient:GetName();
        roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
        roleInfoTable.createSecs=PlayerClient:GetCreateTime();
        roleInfoTable.battleStrength=this.GetbattleStrength();
        roleInfoTable.vipLevel=0;
        roleInfoTable.guildId="";
        roleInfoTable.guildLeaderName="";
        roleInfoTable.guildLeaderUid="";
        roleInfoTable.guildName="";
        roleInfoTable.guildLeaderRoleId="";
        roleInfoTable.guildLevel="";
        if CSAPI.IsDomestic() then
            CShiryuSDK:OnRoleInfoUpdate(roleInfoTable)
        end
        CShiryuSDK:OnRoleOnline(roleInfoTable);
    end

end
---离线
function this.OnRoleOffline()
    if  this.ShiryuLogin.success then
        local roleInfoTable={}
        local serverInfo = GetCurrentServer();
        roleInfoTable.uid=PlayerClient:GetUid();
        roleInfoTable.serverId=serverInfo.id;
        roleInfoTable.serverName=serverInfo.serverName;
        roleInfoTable.roleId=PlayerClient:GetUid();
        roleInfoTable.roleLevel=PlayerClient:GetLv();
        roleInfoTable.roleName=PlayerClient:GetName();
        roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
        roleInfoTable.createSecs=PlayerClient:GetCreateTime();
        roleInfoTable.battleStrength=this.GetbattleStrength();
        roleInfoTable.vipLevel=0;
        roleInfoTable.guildId="";
        roleInfoTable.guildLeaderName="";
        roleInfoTable.guildLeaderUid="";
        roleInfoTable.guildName="";
        roleInfoTable.guildLeaderRoleId="";
        roleInfoTable.guildLevel="";
        CShiryuSDK:OnRoleOffline(roleInfoTable);
        if CSAPI.IsDomestic() then
            CShiryuSDK:OnRoleInfoUpdate(roleInfoTable)
        end
    end

end

---关闭支付页面
function this.ClosePurchasePage(gameOrderId)
    if CSAPI.IsDomestic() then
        CShiryuSDK:ClosePurchasePage(gameOrderId);
    end
end

function this.GetDeviceID()
    local deviceId=this.ShiryuLogin.channelExts["deviceId"];
    --print("设备 ID："..deviceId)
    return deviceId;
end

--调查问卷
function this.OpenWebView(url,action)
    MJSdkManagerImpl:OpenWebView(url,action)
end

--sdk运行参数
function this.SdkProperties()
    return this.GetSdkProperties
end

this.Init();