class BoardsController<ApplicationController
    #set_target_boardが各アクションの呼び出しより前に実行されるように、「before_action」を設定
    #only以降により、特定のアクションの時だけ実行される
    before_action :set_target_board, only: %i[show edit update destroy]

    def index
        #pageメソッドを呼ぶことにより、引数に指定したページに表示するデータだけを取得する。デフォルトでは１ページあたり２５件のデータを取得する。
        @boards =Board.page(params[:page])
    end

    def new
        @board = Board.new(flash[:board])
    end

    def create
        board = Board.new(board_params)
        if board.save
            #値が参照されるまでセッションに保存される。一度参照されたら消える。リダイレクト先に渡す。
            flash[:notice] = "「#{board.title}」の掲示板を作成しました"
            redirect_to board
        else
            redirect_to new_board_path, flash: {
                board: board,
                error_messages: board.errors.full_messages
            }
        end
    end

    def show
        @comment = @board.comments.new
    end

    def edit
    end

    def update
        @board.update(board_params)

        redirect_to @board
    end

    def destroy
        @board.delete
        redirect_to boards_path,flash: { notice: "「#{@board.title}」の掲示板が削除されました。"}
    end

    private

    def board_params
        params.require(:board).permit(:name, :title, :body)
    end

    #各アクションが呼び出される前に実行したいメソッドの定義
    #他のメソッドからも参照できるように「@」つける
    def set_target_board
        @board = Board.find(params[:id])
    end
end