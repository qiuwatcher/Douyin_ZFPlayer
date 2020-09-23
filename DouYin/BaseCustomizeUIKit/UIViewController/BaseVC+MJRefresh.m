//
//  BaseVC+MJRefresh.m
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "BaseVC+MJRefresh.h"

@implementation BaseVC (MJRefresh)

///KVO 监听 MJRefresh + 震动特效反馈
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([object isEqual:self.tableViewHeader] &&
        self.tableViewHeader.state == MJRefreshStatePulling) {
        [NSObject feedbackGenerator];
    }else if ([object isEqual:self.tableViewFooter] &&
             self.tableViewFooter.state == MJRefreshStatePulling) {
        [NSObject feedbackGenerator];
    }
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}
#pragma mark —— lazyLoad
-(MJRefreshGifHeader *)mjRefreshGifHeader{
    MJRefreshGifHeader *mjRefreshGifHeader;
    if (!mjRefreshGifHeader) {
        mjRefreshGifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                           refreshingAction:@selector(pullToRefresh)];
        // 设置普通状态的动画图片
        [mjRefreshGifHeader setImages:@[kIMG(@"官方")]
                             forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [mjRefreshGifHeader setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                             forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [mjRefreshGifHeader setImages:dataMutArr
                             duration:0.7
                             forState:MJRefreshStateRefreshing];
        // 设置文字
        [mjRefreshGifHeader setTitle:@"Click or drag down to refresh"
                            forState:MJRefreshStateIdle];
        [mjRefreshGifHeader setTitle:@"Loading more ..."
                            forState:MJRefreshStateRefreshing];
        [mjRefreshGifHeader setTitle:@"No more data"
                            forState:MJRefreshStateNoMoreData];
        // 设置字体
        mjRefreshGifHeader.stateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        // 设置颜色
        mjRefreshGifHeader.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [self addObserver:self
               forKeyPath:@"state"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }return mjRefreshGifHeader;
}

-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter{
    MJRefreshAutoGifFooter *mjRefreshAutoGifFooter;
    if (!mjRefreshAutoGifFooter) {
        mjRefreshAutoGifFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self
                                                                   refreshingAction:@selector(loadMoreRefresh)];
        // 设置普通状态的动画图片
        [mjRefreshAutoGifFooter setImages:@[kIMG(@"官方")]
                                 forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [mjRefreshAutoGifFooter setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                                 forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [mjRefreshAutoGifFooter setImages:dataMutArr
                                 duration:0.4
                                 forState:MJRefreshStateRefreshing];
        // 设置文字
        [mjRefreshAutoGifFooter setTitle:@"Click or drag up to refresh"
                                forState:MJRefreshStateIdle];
        [mjRefreshAutoGifFooter setTitle:@"Loading more ..."
                                forState:MJRefreshStateRefreshing];
        [mjRefreshAutoGifFooter setTitle:@"No more data"
                                forState:MJRefreshStateNoMoreData];
        // 设置字体
        mjRefreshAutoGifFooter.stateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        // 设置颜色
        mjRefreshAutoGifFooter.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [self addObserver:self
               forKeyPath:@"state"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        mjRefreshAutoGifFooter.hidden = YES;
    }return mjRefreshAutoGifFooter;
}

-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter{
    MJRefreshBackNormalFooter *mjRefreshBackNormalFooter;
    if (!mjRefreshBackNormalFooter) {
        mjRefreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreRefresh)];
    }return mjRefreshBackNormalFooter;
}

-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter{
    MJRefreshAutoNormalFooter *mjRefreshAutoNormalFooter;
    if (!mjRefreshAutoNormalFooter) {
        @weakify(self)
        mjRefreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            NSLog(@"123");
        }];
        [mjRefreshAutoNormalFooter setTitle:@"没有更多视频" forState:MJRefreshStateNoMoreData];
        mjRefreshAutoNormalFooter.stateLabel.textColor = KGreenColor;
    }return mjRefreshAutoNormalFooter;
}


@end
