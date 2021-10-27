import Head from 'next/head'
import Main from '../components/Main'

export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-black text-white">
      <Head>
        <title>Egyptian NTF's</title>
        <link rel="icon" href="/favicon.png" />
      </Head>

      <Main />

    </div>
  )
}
