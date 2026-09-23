---海外客户端  Google 相关功能 逻辑
--- 后续新增  安卓和ios端  礼物发放都走这里 ，所以不单指，只有谷歌 ，苹果也有
AdvGoogleGit={}
local this=AdvGoogleGit;
---应用外购买的应用场景有
---google play商店用积分point兑换充值商品。
---google play礼品卡充值赠送礼包。
---google预注册奖励的发送。
---apple app store 礼包码兑换礼包。
--- ecid：3010021001  存在预约奖励
this.ecid="";
---SDK返回数据  可以弹出
this.SDKBackAdvGoogleGitTrue=false;
---谷歌预约奖励
function this.GoogleReservationRewards()
    if this.OpenGoogleEnableRules()==false then
       ---print("----------GoogleReservationRewards-------------------")
        return false;
    end
    local commodity= ShopMgr:GetFixedCommodity(30033)
    --print("commodity:"..table.tostring(commodity))
    local TitleName=commodity["cfg"]["sName"]
    local dialogData = {}
    dialogData.content =LanguageMgr:GetTips(1038,TitleName)
    dialogData.okText =LanguageMgr:GetByID(1001)
    dialogData.cancelText =LanguageMgr:GetByID(1002)
    dialogData.okCallBack = function()
        --LogError("commodity:"..table.tostring(commodity))
        ShopCommFunc.HandlePayLogic(commodity,1,nil,AdvGoogleGit.OnSuccess,nil,PayType.ZiLongGitPay,true);
    end
    dialogData.cancelCallBack = function()  end
    CSAPI.OpenView("Dialog", dialogData)
    return true
end

function this.OnSuccess(proto)
    if  proto and next(proto.gets) then
        UIUtil:OpenReward( {proto.gets})
    end
end

---开启谷歌奖励规则
function this.OpenGoogleEnableRules()
    ---编码 核对
    --if tostring(this.ecid)~="3010021001" then
    --    print("Google Git-----SDK-----this.ecid--------："..this.ecid)
    --    return false;
    --end
    if this.SDKBackAdvGoogleGitTrue==false then
       -- print("Google Git-----SDK-------------返回没有")
        return false;
    end
    if CSAPI.IsViewOpen("Dialog") then
        return false;
    end
    if CSAPI.IsViewOpen("UserName") then
        return false;
    end
    if CSAPI.IsViewOpen("Fight") then
        return false;
    end
    if CSAPI.IsViewOpen("Skill") then
        return false;
    end
    if CSAPI.IsViewOpen("Guide") then
        return false;
    end
    if CSAPI.IsViewOpen("Menu") ==false then
        return false;
    end
    ---安卓平台下
    --if UnityEngine.Application.platform ~= UnityEngine.RuntimePlatform.Android then
    --    print("Google Git----------平台不对---")
    --    return false;
    --end
    ---邮件解锁状态， 未解锁 就无法触发
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "MailView")
    if isOpen then
        print("邮箱已经解锁----------------")
    else
        print("邮箱没有解锁----------------")
        return false;
    end
    this.SDKBackAdvGoogleGitTrue=false;
    return true;
end