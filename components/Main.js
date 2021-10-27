function Main() {
    return (
      <main className="flex flex-col flex-1 items-center w-full text-center">
        <h1 className="m-4  text-6xl leading-relaxed font-bold">
          Welcome to <p className="bg-gradient-to-r from-yellow-400 to-red-600 text-transparent bg-clip-text text-6xl leading-relaxed">Egyptian NFT's!</p>
        </h1>

        <div className="p-4 font-bold text-xl">
            <p>Each unique. Each beutiful.</p>
            <p>Discover your NFT today!</p>
        </div>

        <button className="m-4 p-4 bg-gradient-to-r from-yellow-400 to-red-600 text-2xl font-bold rounded">
            Connect Wallet!
        </button>
      </main>
    );
}

export default Main