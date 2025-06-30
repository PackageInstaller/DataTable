local ShopMock = BaseClass("ShopMock", Singleton)

local function ShopInfo(reqMsg)
    local rspMsg = 
    {
        shops = 
        {
            -- {
            --     id = 1,
            --     goods = {
            --         {
            --             id = 3014,
	        --             buy_times = 2,
	        --             visible = true,
	        --             visible_time = 4,
	        --             on_sale = true,
	        --             on_sale_time = 6,
	        --             refresh_time = 7
            --         },
            --         {
            --             id = 3001,
	        --             buy_times = 2,
	        --             visible = true,
	        --             visible_time = 4,
	        --             on_sale = true,
	        --             on_sale_time = 6,
	        --             refresh_time = 7
            --         }
            --     },
            --     refresh_time = 1
            -- },
            -- {
            --     id = 2,
            --     goods = {
            --         {
            --             id = 3001,
	        --             buy_times = 2,
	        --             visible = true,
	        --             visible_time = 4,
	        --             on_sale = true,
	        --             on_sale_time = 6,
	        --             refresh_time = 7
            --         }
            --     },
            --     refresh_time = 1
            -- },
            -- {
            --     id = 7,
            --     goods = {
            --         {
            --             id = 301,
	        --             buy_times = 1,
	        --             refresh_time = 7
            --         }
            --     },
            --     refresh_time = 1
            -- }
        },
    }
    return rspMsg
end

local function buyGoods(reqMsg)
    local rspMsg ={

    }
    return rspMsg
end

local function PaymentInfo()
    local rspMsg ={
        payment_info = {
            shop = {
                id = 1,
                goods = {
                    {
                        id = 1,
                        buy_times = 1,
                        refresh_time = 7
                    },
                    {
                        id = 3,
                        buy_times = 2,
                        refresh_time = 7
                    }
                },
                refresh_time = 1
            }
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ShopInfoReq, ShopInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.BuyGoodsReq, buyGoods)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.PaymentInfoReq, PaymentInfo)
end

local function __delete(self)
end

ShopMock.__init = __init
ShopMock.__delete = __delete


return ShopMock