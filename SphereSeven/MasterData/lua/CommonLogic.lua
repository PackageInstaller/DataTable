--此腳本邏輯與服務器黃用,如修改服得器也得更新
CommonLogic = {}
--一个附加奖励計算加密
function CommonLogic.ValueToKey(type,pct)
    local n = math.random(20, 1000)
    local pn = pct*100+n*type
    return n,pn
end
--
function CommonLogic.KeyToValue(type,n,pn)
    local ptc = (pn - n * type) * 0.0001
    return ptc
end
--





return CommonLogic