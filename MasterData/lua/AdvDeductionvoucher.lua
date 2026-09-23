
---海外抵扣券相关
AdvDeductionvoucher={}
local this=AdvDeductionvoucher;
---SDK 抵扣券数量
this.SDKvoucherNum=0;
---支付类型
--this.Paymenttype=PayType.ZiLongDeductionvoucher
--this.Paymenttype=PayType.ZiLong
--PayType.ZiLongGitPay
---查询刷新抵扣券
function this.QueryPoints(action)
    ShiryuSDK.QueryPoints(function(success,voucherNum)
        if success then
            Log("有抵扣卷......："..voucherNum)
            this.SDKvoucherNum=voucherNum;
            if action then action(); end
        else
            Log("没有抵扣券")
            if action then action(); end
        end
    end)
end