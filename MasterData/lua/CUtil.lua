local this = {};


function this:PushArrToArr(originArr,targetArr)
    for _,v in ipairs(originArr)do
        table.insert(targetArr,v);
    end
end

return this;